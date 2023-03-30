# terraform-sample-aws-ec2-environemnt
a project that creates a public VPC with public instances (to be used for testing purposes).

The terraform code destroyes the instances at every apply.

*This code has been generated with ChatGPT and has been modified*

It assumes that there is an ssh key configured in the system called `ansible`.

The ansible playbook is simple but the configuration should work out-of-the box. However, the ssh key must be configured in the local environment to be able to reach out the instances.

# how to use this project

1. terraform init
2. terraform apply
3. ansible-galaxy install -r requirements.yml
4. ansible-playbook main.yml -u ec2-user --private-key=~/.ssh/YOUR_KEY
