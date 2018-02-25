# RStudio Server Installation - Provisioning

After the infrastructure was created by terraform, the virtual machines are provisioned by this playbook to setup the whole rstudio server

## Setup this Playbook

* Install ansible (for this example we used 2.4)
* Exoscale Account (for using the api key and the security key)
* Install [cloudstack api](https://github.com/exoscale/cs)
* Create a cloudstack.ini file to setup cloudstack api.

## Run this example
After successful setup your playbook, you just need to run following command to start the deployment

     ansible-playbook ./rstudio-deployment.yml -i ../inventory

## Configure Cloudstack API

To configure the cloudstack api you need to add a cloudstack.ini file in the root of this example. You need to
define the endpoint as well as the API Key and the API secret. Here is an example how the configuration could
look like:

     [cloudstack]
     endpoint = https://api.exoscale.ch/compute
     key = EX11142dd65bd311fe6aa6dd0f2
     secret = n1KgzB928TWPVVc1PwEvTw89lKl1dpwgc1yvshGwbB4x
