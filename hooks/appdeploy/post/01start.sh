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

if [[ "$EB_SYSTEM_STARTUP" != "true" ]];
then
  OUT=$(/etc/init.d/tomcat7 start 2>&1; /usr/bin/monit monitor tomcat 2>&1) || error_exit "Failed to signal process manager to start tomcat: $OUT" $? 
fi

