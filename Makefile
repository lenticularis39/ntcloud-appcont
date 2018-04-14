deploy: upload_image
	oc tag -d cloud-nt/appcont:dev
	oc tag --source=docker lenticularis/appcont:dev cloud-nt/appcont:dev

upload_image: build_image
	docker push lenticularis/appcont:dev

build_image: Dockerfile init.sh vncpasswd ftppasswd desktop.conf gtk3-settings.ini
	sudo docker build -t lenticularis/appcont:dev .
