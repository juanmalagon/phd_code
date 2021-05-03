#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug 31 23:14:06 2020

@author: juan
"""

import os
import glob
import shutil

os.chdir('/home/juan/Downloads/educacion_formal_2016')

target_pattern = "**/*.txt"
glob.glob(target_pattern)

dest_dir = '/home/juan/Downloads/2016'

for filename in glob.glob(target_pattern):
    shutil.copy(filename, dest_dir)
