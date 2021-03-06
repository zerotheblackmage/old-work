#!/usr/bin/env python3.5

import httplib2
import datetime
import subprocess
import argparse

from apiclient import discovery
from oauth2client.service_account import ServiceAccountCredentials

# argument parsing variable
parser = argparse.ArgumentParser()
parser.add_argument("username", type=str, help="process just a single user, use all for everyone in the company")
args = parser.parse_args()
users_ret = args.username

# Variables needed for the google calendar api authentication
SCOPES = 'https://www.googleapis.com/auth/calendar'
APPLICATION_NAME = 'Caltool'
cred_file = #credentials .json for the service acocunt goes here
credentials = ServiceAccountCredentials.from_json_keyfile_name( cred_file, scopes=SCOPES)
now = datetime.datetime.utcnow().isoformat() + 'Z'  # 'Z' indicates UTC time
domain = #insert domain here

# Function to get and print all the calendars that a user is subscribed to
def caltool(name):
    email = name + "@" + domain
    eq = "="*len(email)
    print(eq + "\n" + email + "\n" + eq)
    # delegated credentials because we're using a service account
    delegated_credentials = credentials.create_delegated(email)
    http = delegated_credentials.authorize(httplib2.Http())
    service = discovery.build('calendar', 'v3', http=http)
    # get the info. specifically it's the 'items' list we need from this dict
    calendar = service.calendarList().list().execute()
    calitems = str(calendar['items']).split(',')
    for i in calitems:
        x = i.replace("'", '').replace('{', '').replace('}', '')
        if str(x).startswith(" summ"):
            x = x.split(':')
            print(x[1][1:])


# Function to get a list of usable users to use
def getusers():
    users = []
    raw = subprocess.check_output("getent passwd", shell=True)
    line = str(raw).split(":")
    for s in line:
        if s.startswith("/home"):
            users.append(str(s)[6:])
    users.sort()
    # print(users)
    for u in users:
        try:
            caltool(u)
            # print(u)
        except:
            print("No calendars for " + u)

if str(users_ret) == "all":
    getusers()
else:
    caltool(str(users_ret))




