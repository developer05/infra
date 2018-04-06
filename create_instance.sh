#! /bin/bash
APP_NAME="symfony-app"
gsutil rm -r gs://$APP_NAME
gsutil mb gs://$APP_NAME
gsutil cp ./startupscript.sh gs://$APP_NAME
gcloud compute instances create --boot-disk-size=10GB --image=ubuntu-1604-xenial-v20170815a --image-project=ubuntu-os-cloud --machine-type=g1-small --tags http-server --restart-on-failure --zone=europe-west1-b --scopes storage-ro --metadata startup-script-url=gs://$APP_NAME/startupscript.sh $APP_NAME
