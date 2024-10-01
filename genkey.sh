#! /bin/sh

jks=src/main/resources/ssl-server.jks
alias=selfsigned_localhost_sslserver
pass=changeit

[ -f "$jks" ] && rm -f $jks
keytool -genkey -alias $alias -keyalg RSA -keysize 2048 -validity 700 -keypass $pass -storepass $pass -keystore $jks

# import to keystore
[ -n "$JAVA_HOME" ] && keytool -importkeystore -srckeystore $jks -srcstorepass $pass -srcalias $alias -destkeystore $JAVA_HOME/lib/security/cacerts -destkeypass $pass -destkeystorepass $pass

# export a cert
keytool -exportcert -alias $alias -keystore $jks -storepass $pass -rfc -file ~/Documents/java-cert.pem
