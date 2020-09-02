# Admission Control Demo

## Requirements:
- Docker Desktop with K8s installed
- Cloud One Tenant with Container Security

## How-To:

- Generate a Cloud One Container Security API Key and change your API Key in the ```overrides.yaml```
- Deploy the Admission Controller Pod:

```helm install trendmicro --values overrides.yaml https://github.com/trendmicro/cloudone-admission-controller-helm/archive/master.tar.gz```

- Create a policy to Block or Log the events:
     - Privileged Containers;
     - Containers with privilege escalation rights;

- Try to deploy the K8s ```kubectl delete -f deployment.yml```

## Result:

You should be able to see Block/Log events in the console, you can play with both of the options or add more...

## Cleanup

To delete the Admission Control Pod just execute ```helm delete trendmicro``` to delete the K8s deployment just execute ```kubectl delete -f deployment.yaml```