#!/usr/bin/env zsh

# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$_";
}

# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi
    if [[ -n "$@" ]]; then
        command du $arg -- "$@";
    else
        command du $arg .[^.]* ./*;
    fi;
}

# Get gzipped size
function gzsize() {
    echo "orig size    (bytes): "
    cat "$1" | wc -c
    echo "gzipped size (bytes): "
    gzip -c "$1" | wc -c
}

# whois a domain or a URL
function whois() {
    local domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
    if [ -z $domain ] ; then
        domain=$1
    fi
    echo "Getting whois record for: $domain …"

    # avoid recursion
    # this is the best whois server
    # strip extra fluff
    /usr/bin/whois -h whois.internic.net $domain | sed '/NOTICE:/q'
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
    if [ -z "${1}" ]; then
        echo "ERROR: No domain specified.";
        return 1;
    fi;

    local domain="${1}";
    echo "Testing ${domain}...";
    echo ""; # newline

    local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
        | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

    if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
        local certText=$(echo "${tmp}" \
            | openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
            no_serial, no_sigdump, no_signame, no_validity, no_version");
        echo "Common Name:";
        echo ""; # newline
        echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
        echo ""; # newline
        echo "Subject Alternative Name(s):";
        echo ""; # newline
        echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
            | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
        return 0;
    else
        echo "ERROR: Certificate not found.";
        return 1;
    fi;
}

# Show active network interfaces
function ifactive() {
    local iface
    for iface in $(ifconfig -l); do
        ifconfig "$iface" | grep -q 'status: active' && ifconfig "$iface"
    done
}

killport() {
  if [ -z "$1" ]; then
    echo "Usage: killport <port> [port ...]"
    return 1
  fi

  local port pids
  for port in "$@"; do
    pids=$(lsof -ti tcp:"$port")
    if [ -z "$pids" ]; then
      echo "No process found on port $port"
      continue
    fi
    echo "Killing process(es) $pids on port $port..."
    echo "$pids" | xargs kill -9 && echo "Done."
  done
}
