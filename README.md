**Terraform EC2 Instance with Ansible Playbook**

This project is a proof of concept that uses Terraform to create an Amazon EC2 instance and then uses Ansible to configure it. The public IP of the EC2 instance is obtained through Terraform's output, which is then used to trigger a GitHub Action.

**Features**

* Terraform is used to provision an EC2 instance on AWS.
* The public IP of the EC2 instance is obtained through Terraform's output.
* A GitHub Action is triggered on the merge of the ansible_action branch.
* The GitHub Action downloads and runs an Ansible playbook.
* The Ansible playbook configures the EC2 instance by installing Nginx.

**Prerequisites**

* You need to have Terraform installed on your machine.
* You need to have an AWS account and your AWS credentials should be configured on your machine.
* You need to have Ansible installed on your machine.

**Usage**

1. Clone the repository.
2. Navigate to the repository directory.
3. Run terraform init to initialize your Terraform workspace.
4. Run terraform apply to create the EC2 instance.
5. Merge the ansible_action branch to trigger the GitHub Action.
6. The GitHub Action will run the Ansible playbook on the EC2 instance.