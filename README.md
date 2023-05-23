# terraform-jenkins-server
TF code for deploying a Jenkins server.

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
1. Review the plan created by the `Terraform Plan` job and confirm that four resources will be created:

    1. ✅ create	aws_instance.ec2["jenkins-production-0"]
    1. ✅ create	aws_security_group.ec2
    1. ✅ create	aws_security_group_rule.ec2-egress
    1. ✅ create	aws_security_group_rule.ec2-http

1. Reivew and approve the deployment to start the `Terraform Apply` job.
1. Wait for the deployment to complete.
1. Select the URL for `jenkins-production-0` under the "Apply complete!" message.
1. If the page displays "Welcome to nginx!", wait for a few minutes until the Jenkins software installation completes.
1. Refresh the page and you should be prompted for the Initial Admin Password.

## TODO: Figure out why the system log is not being displayed

        INSTANCE_ID=$(aws ec2 describe-instances --region=YOUR_REGION --filters Name=instance-state-name,Values=running --query='Reservations[].Instances[].InstanceId' --output=text)

        aws ec2 --region=YOUR_REGION get-console-output --instance-id="${INSTANCE_ID}" --output=text

## Clean Up
1. Run the workflow [99-Destroy Resources](./.github/workflows/destroy-resources.yml).
1. Review the plan created by the `Terraform Plan` job and confirm that four resources will be destroyed:

    1. ‼️ destroy aws_instance.ec2["jenkins-production-0"]
    1. ‼️ destroy aws_security_group.ec2
    1. ‼️ destroy aws_security_group_rule.ec2-egress
    1. ‼️ destroy aws_security_group_rule.ec2-http

1. Reivew and approve the deployment to start the `Terraform Apply` job.
1. Wait for the deployment to complete.