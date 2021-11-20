#!/bin/bash

logfile="/tmp/test_log"
trap cleanup EXIT SIGINT

function cleanup() {
  trap - EXIT SIGINT
  echo tetsts
  rm -f ${logfile}
  exit 1
}

## VARS
LOG_DONE="DONE!!!"
MSG_DONE="You are the best!"
LOG_FAIL="FAIL!!!"
MSG_FAIL="Don't worry! Next time..."

function log_msg() {
  echo "$*" >> $logfile
}

echo TEST1
bash spinner --logfile "$logfile" --log_done "${LOG_DONE}" --msg_done "${MSG_DONE}" \
                                  --log_fail "${LOG_FAIL}" --msg_fail "${MSG_FAIL}" run &

log_msg "Test_1 start"
sleep 0.5
for i in {0..99}; do
  sleep 0.1
  log_msg "$i% complete"
done

log_msg "${LOG_DONE}"
sleep 1
echo

echo TEST2
bash spinner --logfile "$logfile" --log_done "${LOG_DONE}" --msg_done "${MSG_DONE}" \
                                  --log_fail "${LOG_FAIL}" --msg_fail "${MSG_FAIL}" run &

log_msg "Test_2 start"
sleep 0.5
for i in {0..99}; do
  sleep 0.1
  log_msg "$i% complete"
done

log_msg "${LOG_FAIL}"
sleep 1
echo
