#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed May  3 09:36:38 2017

@author: rharvison
"""

import os
import glob

scr="/home"


for filename in glob.iglob('src/**/*', recursive=True):
    print(filename)