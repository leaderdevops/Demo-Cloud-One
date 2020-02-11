pipeline {
  agent any
  stages {
    stage('Git Checkout') {
      steps {
        git(url: 'https://github.com/felipecosta09/DSSC.git', branch: 'master')
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t java-app:latest .'
      }
    }

    stage('Push to ECR') {
      steps {
        sh '''docker login -u AWS -p eyJwYXlsb2FkIjoiR1UzRHFIbFN5OHFCdnplYjlJbFVyT1l0QkRiZS9TSmNIQ0JscnhqMGgyV2I1aDVtVGtrc2UrVjFKa1U5RHpubURvK1k2MWVzcUFWQ3NtbWlsVGtVU3R1UlltTSt1VWNneEpMcGkwb1BxMXZjVUdneURWcXJRMXByeVFFcm9zblhPWlFuSTVVNEw3VVVUSlZwMG5vVzUxQjB3YkxlRHg1YlYyRHFkeWZxUzVYZ3J6K24vMzFYaUxPMzRoWmNscFVlM0ZHdjBlejZ3UjBrV2l6WGQ4R0ZBZEJwanhENnBPWG53cjVHYWNSSlJvMXJVelp6N0tkSEYzNUdGeWNmMmRvZ0JaamFhYmN1YnppVi9TOWIxeEI3WldRTlVuOERNWnVQZUpFUG1RcVVVYzdZRzRuYjBGQVVjd1ZKN0RtQXpxTnlpTDhOdDFWUngwM1RReXEvVElUcXpVZ3VSbHhGSTdGSXBsa2Z1VnJscVB3YzBBY3hRcTZ6WGYwNXliOWJEVWpud1FxMTJhTzNzNlA1VlBSWnkvN0dqZWx6K0NTbE5LRlF1S1p6SVhSTlRkWk9ydkNwTU80TkF0RHB6b2ZDRVA5aU1kYXQ5d1hYTTZyZ3N2Rmd5NytPcXloREltbTJ6RUU0TTdsRU1FUjlVcHJ4dDY2bDRyRVZXam9xblc2RGhJOXRvVG1tenBWTGpETTJYOVZnQ1oyblpEdS9VV2JENkxpenYzWE1kZE9jR3g0T0ozbWdMQlhWdzM5U204cytJNXR3T3lJbzAyN0kvbmw4ZkpuU1pwVDgzSjlnditEWU4zeDN0V09VQlF3ZlpxSUxVanB5SjVPc1FWNTJsOEFmZEM2enZ3U2NNTnFxRzcxeGprZDdzQ1I2K3A3YURhRUI0VGJOUi9JZzNYVWtYVUl0M1VCVlpTeHJqRWVBUHphVEppekhjeno4bk0xQlU4ZjBUMUo1Zk1CQVJ5VUxCUi9NQWJqNTViSThqMW0vOEZPZUhsRUxqV2ljbTVjQ25UTTFjNDRUcXVRZFV2RThOWEdETy9zNUpUTkQ4TWR2OFVxdjgyS0FNaGtrYnlDbElPUDhXVEdsRG5ZS01YTDZGRWVpS3pJaXBsQTNXWVErbzMySjFkQit3UEdjTnpPL3FHNkNNck52Y2U1M3BPd2R6eWU3N3Jrak5UbkJBclVCUE9SVHFEWTRKVlVEWVZLVlRqc1NkUGowbnZVZXpQZ082aCtEUDhtcDFoVTY3dnNTUDlEL2VPeU55TnVPK0lXS2lZZXFsNVRKZUJBTEFjSDBIOTVTSmx5eHdsZ3dVRFJZZmx6dWNVWHpIUFg0L2JvbE9NNEJBd3hmQ2Zxd2RpQXpEa2NOZWgxVkdDN2FLeDJWeU5DdXRkdldLZTN2SUFYKzl6R1dsa1dmRUltb09na3l5TVlXT1ZrVTY2WVFwQm0yMVpzS2JSTVphcEp1dGpEUGZYaGpvQT09IiwiZGF0YWtleSI6IkFRRUJBSGh3bTBZYUlTSmVSdEptNW4xRzZ1cWVla1h1b1hYUGU1VUZjZTlScTgvMTR3QUFBSDR3ZkFZSktvWklodmNOQVFjR29HOHdiUUlCQURCb0Jna3Foa2lHOXcwQkJ3RXdIZ1lKWUlaSUFXVURCQUV1TUJFRURFWUp4MDVqajVRTGp4UDhMd0lCRUlBN0NWazVEWXZCakJNcG1TOVNaOHo3S1VmbnR6SnpydkFaL2UrMGxPZEpIK0ZTWUlWSmFmcWIrVktEdXNqRzREN1JETWhaZC9UTXdCcWZrZzA9IiwidmVyc2lvbiI6IjIiLCJ0eXBlIjoiREFUQV9LRVkiLCJleHBpcmF0aW9uIjoxNTgxNDYxMjU2fQ== https://650143975734.dkr.ecr.us-east-1.amazonaws.com
docker tag java-app:latest 650143975734.dkr.ecr.us-east-1.amazonaws.com/dssc
docker push 650143975734.dkr.ecr.us-east-1.amazonaws.com/dssc:latest'''
      }
    }

    stage('Cloud One Container Image Scan') {
      steps {
        sh 'echo \'TBD\''
      }
    }

    stage('Deploy') {
      steps {
        sh 'sudo aws s3 ls'
      }
    }

  }
}