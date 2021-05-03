# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import os
import unidecode

def rename_all_files(path, extension):
    os.chdir(path)
    file_list = os.listdir()
    file_list = [document for document in file_list if document.endswith(extension)]
    file_list_fixed = [unidecode.unidecode(name) for name in file_list]
    zipped = zip(file_list, file_list_fixed)
    for x,y in zipped:
        os.rename(x,y)
    return

path = 'J:\SBE_ROA\Malagon-Haelermans\dane\educacion_formal_2014'

extension = '.csv'
rename_all_files(path, extension)

extension = '.txt'
rename_all_files(path, extension)