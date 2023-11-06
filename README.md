# A simple shell script to update namecheap's domain ip address.
Set requested parameters in the script like:
    HOSTNAME=(subdomain)
    DOMAIN=(maindomain)
    SECRET_LOCATION=(location of the password file/ default path is good enough)

run ./namecheap-ddns.sh -set > a promt will appear, then provide the namecheap password,
    This will generate a password file with a minimum required privileges.

Usage: ./namecheap-ddns.sh (this will check if the current host-IP(where the script is running) is the same as the 
    given sub.domain-IP, if not update it.)
