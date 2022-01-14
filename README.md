I tried to make the depoyment simple so that we can apply once and get the infra up. This strature is highly not recommded for Production Deployment.
For now I have not integrated with cloud watch to auto scale and downscale.
To scale up and down front end server update the numbers  in front-end-launch-config.tf 

max_size                  = 1
min_size                  = 1
desired_capacity          = 1

Steps to reproduce 
1. terraform init 
2. terraform plan
3. terraform apply 


Forked and updated db uri into GitHub repo
https://github.com/indra281/FlaskWithMongoDB.git

##############################################################################

To install mongo db we are passing install script as user data.

##############################################################################

To Cconfigure and install front end server we are passing user data to install python and dependency. and run app.py

#############################################################################

Attached Static Network "10.15.72.91" to db isnatce as we have static db uri conigured in the program 

############################################################################



Once we apply terraform we will see load-balancer-dns  as output and from that dns url we can access frontend

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

load-balancer-dns = "demo-alb-ae4f1ac24f783acc.elb.us-east-1.amazonaws.com"
subnet_private0 = "subnet-045e9a4b70f4490a4"
subnet_private1 = "subnet-063a533e47082fcc0"
subnet_public0 = "subnet-02691f1bf57c99b83"
subnet_public1 = "subnet-010c3022dc3226bb1"
vpcid = "vpc-07dfc5c479d46264e"

