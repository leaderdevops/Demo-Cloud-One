action "Scan with Deep Security Smart Check" {
  uses = "docker://deepsecurity/smartcheck-scan-action"
  secrets = [
    "DSSC_SMARTCHECK_HOST",
    "DSSC_SMARTCHECK_USER",
    "DSSC_SMARTCHECK_PASSWORD",
    "DSSC_IMAGE_PULL_AUTH"
  ]
  args = ["--image-name registry.example.com/my-project/my-image"]
}
