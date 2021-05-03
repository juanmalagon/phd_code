# -*- coding: utf-8 -*-
"""
Created on Mon Mar 15 18:48:06 2021

@author: P70070356
"""

import os
import pandas as pd
import logging

from unidecode import unidecode
from io import StringIO

logging.basicConfig(level=logging.DEBUG)

path='J:\SBE_ROA\Malagon-Haelermans\\ftpdbicfes\\4. Saber11\\3. Resultados Saber11'

os.chdir(path)

# file_encoding = pd.read_csv('sep_safe.csv')


# def fix_file(i=0):
#     instance = pd.read_table(file_encoding.loc[i, 'file']
#                              , encoding=file_encoding.loc[i, 'encoding']
#                              , sep=file_encoding.loc[i, 'sep']
#                              , dtype='str'
#                              , error_bad_lines=False
#                              , warn_bad_lines=True
#                              # , header=0
#                               , engine='python'
#                              ).astype('str')
#     instance_fixed = instance.applymap(unidecode)
#     instance_fixed.to_csv(file_encoding.loc[i, 'file'][:-4]+'.csv'
#                           , encoding='utf-8')
    
# for i in range(len(file_encoding)):
#     my_file = open(file_encoding.loc[i, 'file'], 'rb+')
#     raw_text = my_file.read().decode(file_encoding.loc[i, 'file'])
#     deco_file = open(path +'\deco_' + file_encoding.loc[i, 'file'],'w')
#     deco_text = unidecode(raw_text)
#     deco_file.write(deco_text)
#     deco_file.close()
#     my_file.close()


# for i in range(len(file_encoding)):
#     fix_file(i)

# for i in range(27,(len(file_encoding))):
#     fix_file(i)


# i=0



file_encoding = pd.read_csv('sep_safe.csv')

def reencoder(i):
    my_file = open(file_encoding.loc[i, 'file'], 'rb+')
    raw_text = my_file.read().decode(file_encoding.loc[i, 'encoding']).replace(file_encoding.loc[i, 'sep'], '\t')
    TESTDATA = StringIO(raw_text)
    df = pd.read_csv(TESTDATA
                     # , sep=file_encoding.loc[i, 'sep']
                     , sep='\t'
                     # , low_memory=False
                     , dtype='str'
                     )
    df.to_csv(path +'\deco_' + file_encoding.loc[i, 'file'][:-4]+'.csv', sep='\t')
    # raw_text = raw_text.replace(file_encoding.loc[i, 'sep'], '\t')
    # deco_file = open(path +'\deco_' + file_encoding.loc[i, 'file'],'w')
    # deco_text = unidecode(raw_text)
    # deco_file.write(deco_text)
    # deco_file.close()
    my_file.close()

# deco_file.close()
# my_file.close()


for i in range(len(file_encoding)):
    logging.info('Processing file {}'.format(i))
    reencoder(i)
    logging.info('Succedded!')

file_encoding = pd.read_csv('sep_safe.csv')


for i in range(22,len(file_encoding)):
    reencoder(i)



# my_file = open(file_encoding.loc[i, 'file'], 'rb+')
# raw_text = my_file.read().decode(file_encoding.loc[i, 'encoding'])
# raw_text = raw_text.replace(file_encoding.loc[i, 'sep'], '\t')
# deco_file = open(path +'\deco_' + file_encoding.loc[i, 'file'],'w')
# deco_text = unidecode(raw_text)
# deco_file.write(deco_text)
# deco_file.close()
# my_file.close()

# instance = pd.read_table(file_encoding.loc[i, 'file']
#                          , encoding=file_encoding.loc[i, 'encoding']
#                          , sep='|'
#                          , dtype='str'
#                          ).astype('str')

# instance.dtypes

# instance_fixed = instance.applymap(unidecode)
# # instance_fixed = instance_fixed.replace('nan', None)
# instance_fixed.to_csv(file_encoding.loc[i, 'file'][:-4]+'.csv'
#                       , encoding='utf-8')


# i=1

# instance = pd.read_table(file_encoding.loc[i, 'file']
#                          , encoding=file_encoding.loc[i, 'encoding']
#                          , sep='|'
#                          , dtype='str'
#                          ).astype('str')

# instance.dtypes

# instance_fixed = instance.applymap(unidecode)
# # instance_fixed = instance_fixed.replace('nan', None)
# instance_fixed.to_csv(file_encoding.loc[i, 'file'][:-4]+'.csv'
#                       , encoding='utf-8')
