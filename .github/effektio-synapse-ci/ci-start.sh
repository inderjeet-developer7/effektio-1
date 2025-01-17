#!/bin/bash
set -e
export SYNAPSE_SERVER_NAME=ds9.effektio.org
export SYNAPSE_REPORT_STATS=no
echo " ====== Generating config  ====== "
/start.py generate
echo " ====== Patching for CI  ====== "
sed -i 's/^#allow_guest_access:.*$/allow_guest_access: true/g' /data/homeserver.yaml
sed -i 's/^#enable_registration_without_verification:.*$/enable_registration_without_verification: true/g' /data/homeserver.yaml
sed -i 's/^#enable_registration:.*$/enable_registration: true/g' /data/homeserver.yaml
echo """

rc_message:
  per_second: 1000
  burst_count: 1000

rc_registration:
  per_second: 1000
  burst_count: 1000

rc_login:
  address:
    per_second: 1000
    burst_count: 1000
  account:
    per_second: 1000
    burst_count: 1000
  failed_attempts:
    per_second: 1000
    burst_count: 1000

rc_admin_redaction:
  per_second: 1000
  burst_count: 1000

rc_joins:
  local:
    per_second: 1000
    burst_count: 1000
  remote:
    per_second: 1000
    burst_count: 1000

rc_3pid_validation:
  per_second: 1000
  burst_count: 1000

rc_invites:
  per_room:
    per_second: 1000
    burst_count: 1000
  per_user:
    per_second: 1000
    burst_count: 1000

""" >>  /data/homeserver.yaml

echo " ====== Starting server with:  ====== "
cat /data/homeserver.yaml
echo  " ====== STARTING  ====== " 
/start.py run