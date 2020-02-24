#!/bin/bash

USER='${{ secrets.DSSC_USER }}'
ECR_BASE='${{ secrets.ECR_LOGIN }}'
ECR_REPO='${{ secrets.ECR_REPO }}'

NEW_PASSWORD='${{ secrets.DSSC_PSW }}'
SMART_CHECK='${{ secrets.DSSC_HOST }}'
ORIGNAL_PASSWORD=${NEW_PASSWORD}
URL=https://${SMART_CHECK}
CURL=curl
SCANURI=${URL}/api/scans
SESSIONURI=${URL}/api/sessions
CHANGEPASSWORDURI=${URL}/api/
CONTENTTYPE='context type application/json'
PERMITTEDHIGHVULNERABILITIES=0
OUT_OF_COMPLIANCE=0

USER_JSON='{"user": {"userid":\"${USER}\","password":\"${PASSWORD}\"}}'

${CURL} -sk -X POST ${SESSIONURI} -H 'Content-type:application/json' -H 'X-Api-Version:2018-05-01' -d '{"user": {"userid":"'${USER}'","password":"'${ORIGNAL_PASSWORD}'"}}'  > raw
cat raw | jq .user.passwordChangeRequired >changepassword
cat raw | jq .token  > token
TEMP_TOKEN=`cat token`
sed -e 's/^"//' -e 's/"$//' <<< ${TEMP_TOKEN} > token
TOKEN=`cat token`

if [ -z ${TOKEN} ] ; then
  ${CURL} -sk -X POST ${SESSIONURI} -H 'Content-type:application/json' -H 'X-Api-Version:2018-05-01' -d '{"user": {"userid":"'${USER}'","password":"'${NEW_PASSWORD}'"}}'  > raw
  cat raw | jq .token  > token
  TEMP_TOKEN=`cat token`
  sed -e 's/^"//' -e 's/"$//' <<< ${TEMP_TOKEN} > token
  TOKEN=`cat token`
fi

${CURL} -sk -X POST ${SCANURI} -H 'Content-type:application/json' -H "Authorization: Bearer ${TOKEN}" \
    -d '{
  "id": "",
  "name": "myScan",
  "source": {
    "type": "docker",
    "registry": "'${ECR_BASE}'",
    "repository": "'${ECR_REPO}'",
    "tag": "latest",
    "credentials": {
      "token": "",
      "username": "",
      "password": "",
      "aws": {
        "region": "us-east-1",
        "accessKeyID": "",
        "secretAccessKey": "",
        "role": "",
        "externalID": "",
        "roleSessionName": "",
        "registry": ""
      }
    },
    "insecureSkipVerify": true,
    "rootCAs": ""
  }
} ' | jq .href > href || exit -10


TEMP_HREF=`cat href`
sed -e 's/^"//' -e 's/"$//' <<< ${TEMP_HREF} > href
HREF=`cat href`


${CURL} -sk -X GET ${URL}${HREF} -H 'Content-type:application/json' -H "Authorization: Bearer ${TOKEN}"  > status

TMP=`grep pending status`
while [  -n "$TMP"  ]; do
        sleep 1
        ${CURL} -sk -X GET ${URL}${HREF} -H 'Content-type:application/json' -H "Authorization: Bearer ${TOKEN}" > status
        TMP=`grep pending  status`
done
TMP=`grep progress  status`
while [  -n "$TMP"  ]; do
        sleep 1
        ${CURL} -sk -X GET ${URL}${HREF} -H 'Content-type:application/json' -H "Authorization: Bearer ${TOKEN}" > status
        TMP=`grep progress  status`
done

if [[ $TMP = *"completed-no-findings"* ]]; then
  echo "--------------------------------------------------------------------------------------------"
  echo "Deep Security Smart Check scan sucessful. You don't have any compliance issues!"
  echo "--------------------------------------------------------------------------------------------"
  exit 0
else

  echo "--------------------------------------------------------------------------------------------"
  echo "Deep Security Smart Check scan found some issues"
  echo "--------------------------------------------------------------------------------------------"

  ID=$(cat status | jq .id)
  if [ -z "${ID}" ] ; then
    echo "Unknown ID, please re-run Smart Check scan."
    exit -75
  fi
  MALWARE=`cat status | jq -r .findings.malware`
  if [[ $MALWARE -ne 0 ]] ; then
    echo "---> Malware detected!"
    #cat status | jq '.details.results[]'  | jq 'select(has("malware"))'
    OUT_OF_COMPLIANCE=1
    #exit -100
  fi

  CONTENT=`cat status | jq -r .findings.contents.total.high`
  #echo "Info"
  #echo "-------------"
  #echo "$CONTENT"
  #echo "-------------"
  if [[ $CONTENT -ne 0 ]]; then
    echo "--->Content Findings detected!"
    #exit -120
    OUT_OF_COMPLIANCE=1
  fi

  HIGHVULNERABILITIES=`cat status | jq -r '.findings.vulnerabilities.unresolved.high'`
  if [[ -n "$HIGHVULNERABILITIES" ]]; then
    if [[ $HIGHVULNERABILITIES -gt $PERMITTEDHIGHVULNERABILITIES ]]; then
      #echo "--------------------------------------------------------------------------------------------"
      echo "--->Number of vulerabilities found is greater than permitted High Vulnerability! "
      echo "- Total number of High Vulnerabilities found: ${HIGHVULNERABILITIES}"
      echo "- Total number of Permitted High Vulnerabilities configured: ${PERMITTEDHIGHVULNERABILITIES}"
      #echo "--------------------------------------------------------------------------------------------"
      #echo "Number of vulerabilities found is greater than permitted High Vulnerability!!!"
      #echo "--------------------------------------------------------------------------------------------"
      #echo "You are out of compliance!!!"
      #echo "--------------------------------------------------------------------------------------------"
      #cat status | jq
      #exit -150
      OUT_OF_COMPLIANCE=1
    else
      echo "--->Number of vulerabilities found is lower than permitted - High Vulnerability!!!"
      if [[ $OUT_OF_COMPLIANCE -ne 1 ]]; then
        exit 0
      fi
    fi
  fi

  if [[ $OUT_OF_COMPLIANCE -ne 0 ]]; then
    echo " "
    echo "Aborting build!"
    echo "--------------------------------------------------------------------------------------------"
    echo "YOU ARE OUT OF COMPLIANCE!!!"
    echo "--------------------------------------------------------------------------------------------"
    echo $TMP
    exit -150
  fi
  echo $TMP
  exit -128
fi
