cd server/src/cert
::Deleiting old certificates
del /f *.pem
del /f *.srl

echo Old certificates deleted... Creating new ones

::Creating password for encryption
openssl rand -base64 8 |openssl dgst -sha256 > passwd.cnf

::Creating CA private key and self signed certificat
openssl req -x509 -newkey rsa:4096 -days 30 -keyout ca-key.pem -out ca-cert.pem -passout file:passwd.cnf -subj "/C=US/ST=TX, L=Austin, O=Global Organization of Oriented Group Language of Earth, OU=Google, CN=ca-privkey-sscert/emailAddress=cohoxo4727@forfity.com"

::Creating server private key and CSR
openssl req -newkey rsa:4096 -keyout server-key.pem -out server-req.pem -passout file:passwd.cnf -subj "/C=SI/ST=Postojna, L=Postojan, O=Local Test Server, OU=Tets Server, CN=ws-privkey-csr/emailAddress=peterusdebevec@gmail.com"

::Creating server certificat and key
openssl x509 -req -in server-req.pem -days 30 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf -passin file:passwd.cnf

::Verifying certificat
openssl verify -CAfile ca-cert.pem server-cert.pem

cls