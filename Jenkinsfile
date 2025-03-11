pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:1.6.0'
            args '--entrypoint=""'  // Prevents issues with Terraform images
        }
    }

    parameters {
        string(name: 'AWS_REGION', defaultValue: 'ap-southeast-2', description: 'AWS region')
        string(name: 'VPC_CIDR', defaultValue: '10.0.0.0/16', description: 'VPC CIDR Block')
        string(name: 'SUBNET_CIDR', defaultValue: '10.0.1.0/24', description: 'Public Subnet CIDR Block')
        string(name: 'INSTANCE_TYPE', defaultValue: 't2.micro', description: 'EC2 instance type')
        string(name: 'KEY_NAME', defaultValue: 'my-key', description: 'Name of the SSH Key Pair')
    }

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY')
    }

    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''terraform plan -out=tfplan \
                -var="aws_region=${AWS_REGION}" \
                -var="vpc_cidr=${VPC_CIDR}" \
                -var="subnet_cidr=${SUBNET_CIDR}" \
                -var="instance_type=${INSTANCE_TYPE}" \
                -var="key_name=${KEY_NAME}"'''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
}
