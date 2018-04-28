deploy: upload_image
	oc tag -d greenhatcloud/appcont:dev
	oc tag --source=docker greenhat:443/appcont:dev greenhatcloud/appcont:dev

upload_image: build_image
	sudo docker push greenhat:443/appcont:dev

build_image: Dockerfile init.sh ftppasswd desktop.conf gtk3-settings.ini
	sudo docker build -t greenhat:443/appcont:dev .
