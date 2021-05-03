#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep  2 22:31:59 2020

@author: juan
"""

import os
# from charset_normalizer import detect

path='J:\SBE_ROA\Malagon-Haelermans\\ftpdbicfes\\4. Saber11\\3. Resultados Saber11'
# # path='J:\SBE_ROA\Malagon-Haelermans\dane\educacion_formal_2019'

# os.chdir(path)
# file_list = os.listdir()
# file_list = [document for document in file_list if (document.endswith('.csv') | document.endswith('.txt'))]

# encoding_list = list()

# for file in file_list:
#     my_file = open(file, 'rb+')
#     raw_text = my_file.read()
#     encoding_list.append(detect(raw_text)['encoding'])
#     my_file.close()

#########

import cchardet as chardet

os.chdir(path)
file_list = os.listdir()
file_list = [document for document in file_list if (document.endswith('.TXT') | document.endswith('.txt'))]

encoding_list2 = list()

for file in file_list:
    my_file = open(file, 'rb+')
    raw_text = my_file.read()
    encoding_list2.append(chardet.detect(raw_text)['encoding'])
    my_file.close()

#########

import pandas as pd

df = pd.DataFrame(zip(file_list, encoding_list2), columns=['file','encoding'])

df.to_csv('file_encoding.csv')
    
# import unidecode

# os.chdir(path)
# file_list = os.listdir()
# file_list = [document for document in file_list if (document.endswith('.csv') | document.endswith('.txt'))]

# for i in range(len(file_list)):
#     my_file = open(file_list[i], 'rb+')
#     raw_text = my_file.read().decode(encoding_list2[i])
#     deco_file = open(path +'\deco_' + file,'w')
#     deco_text = unidecode.unidecode(raw_text)
#     deco_file.write(deco_text)
#     deco_file.close()
#     my_file.close()

# deco_file.close()
# my_file.close()