# terraform-jenkins-ubuntu
TF code for deploying a Jenkins controller on a server running the Ubuntu operating system in Amazon Web Services.
- [Jenkins](https://www.jenkins.io/)
- [Ubuntu Server](https://ubuntu.com/download/server)
- [Amazon Web Services](https://aws.amazon.com/)

## Set Up
> **Warning**: If you cloned or forked this repo, you will need to edit the following files to add your own values:
- [terraform.tf](./terraform.tf): udpate values for `bucket` and `region`.

1. Add the AWS credentials as Actions secrets and Codespace secrets.
1. Start a codespace.
1. Open a terminal and run:

        terraform init
        terraform plan

1. Confirm that both commands run without error.  Fix any errors before proceeding.  Note that pushes to the repo will trigger the pipeline so you may not need to trigger it again manually in the next section if all is well.

## Deploy the Jenkins server
1. Run the [00-Terraform Pipeline](./.github/workflows/terraform-pipeline.yml) workflow.
1. Review the plan created by the `Terraform Plan` job and confirm the resources that will be created.
1. Reivew and approve the deployment to start the `Terraform Apply` job.
1. Wait for the deployment to complete.
1. Select the URL for `jenkins-production-0` under the "Apply complete!" message.
1. If the page displays "Welcome to nginx!", wait for a few minutes until the Jenkins software installation completes.
1. Refresh the page and you should be prompted for the Initial Admin Password.

## Get the Initial Admin Password
1. Run the followig command in the codespace:

        aws ssm get-parameter --region=YOUR_REGION --name "/jenkins/production/initialAdminPassword" --query="Parameter.Value"

## Clean Up
1. Run the workflow [99-Destroy Resources](./.github/workflows/destroy-resources.yml).
1. Review the plan created by the `Terraform Plan` job and confirm the resources that will be destroyed
1. Reivew and approve the deployment to start the `Terraform Apply` job.
1. Wait for the deployment to complete.
