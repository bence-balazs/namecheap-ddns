#!/bin/sh
# a simple shell script to update namecheap's domain ip address.
# usage: ./namecheap-ddns.sh [-set] [-help]

# set variables here
HOSTNAME="blog"
DOMAIN="domain.dev"
SECRET_LOCATION="${HOME}/.namecheap-ddns"

### DO NOT MODIFY BELOW ###
OPTION=${1}
set -euo pipefail

# check given param's if empty print help message.
give_help() {
    echo "usage: ${0} [-COMMAND]: set/help"
    echo
    echo "${0} -set (set password to a file)"
    echo "${0} -help (display help)"
}

# set password to a file and reduce accessibility
set_password() {
    touch "${SECRET_LOCATION}"
    read -rp "Password: " PASSWORD
    echo "${PASSWORD}" > "${SECRET_LOCATION}"
    chmod 0600 "${SECRET_LOCATION}"
}

# compare two ip, if != run update script
update_ip() {
    local DOMAIN_IP="$(dig ${HOSTNAME}.${DOMAIN} +short 2> /dev/null)"
    local HOST_IP="$(curl ifconfig.io 2> /dev/null)"
    local PASSWORD="$(cat ${SECRET_LOCATION})"

    if [ "${DOMAIN_IP}" != "${HOST_IP}" ]; then
        curl "https://dynamicdns.park-your-domain.com/update?host=${HOSTNAME}&domain=${DOMAIN}&password=${PASSWORD}&ip=${HOST_IP}"
    fi
}

# logic start
case ${OPTION} in
    "-set") set_password
    ;;
    "-help") give_help
    ;;
    "") update_ip
    ;;
esac
