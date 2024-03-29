#!/bin/bash
#==============================================================================
# Copyright 2012 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Amazon Software License (the "License"). You may not use
# this file except in compliance with the License. A copy of the License is
# located at
#
#       http://aws.amazon.com/asl/
#
# or in the "license" file accompanying this file. This file is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or
# implied. See the License for the specific language governing permissions
# and limitations under the License.
#==============================================================================


function error_exit
{
  eventHelper.py --msg "$1" --severity ERROR
  exit $2
}

OUT=$(/bin/cp -f /opt/elasticbeanstalk/containerfiles/monit.conf /etc/monit.d/ 2>&1) || error_exit "Failed to copy Monit control file: $OUT" $?
OUT=$(chmod 0600 /etc/monit.d/monit.conf 2>&1) || error_exit "Failed to chmod the Monit contorl file: $OUT" $? 
OUT=$(/usr/bin/monit 2>&1) || error_exit "Failed to signal process manager to start: $OUT" $? 
