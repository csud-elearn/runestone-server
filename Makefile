build:
	docker build -t runestone-server -f Dockerfile .

#
# This assumes you have a "datadir" created
#
DATADIR=datadir
keys:
	cd $(DATADIR) ; openssl genrsa -out server.key 2048
	cd $(DATADIR) ; openssl req -new -key server.key -out server.csr
	cd $(DATADIR) ; openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
