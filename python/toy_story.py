import pandas as pd
import numpy as np

path='/Users/juanmalagon/Desktop/Malagon-Haelermans/ftpdbicfes/4. Saber11/4. Clasificación de Planteles/'
df_2018_2 = pd.read_table(path + 'SB11-CLASIFI-PLANTELES-20182.txt'
                          , engine='python'
                          , encoding='utf-8'
                          , sep='¬'
                          , decimal=','
                          )
df_2018_1 = pd.read_table(path + 'SB11-CLASIFI-PLANTELES-20181.txt'
                          , engine='python'
                          , encoding='latin-1'
                          , sep='|'
                          , decimal='.'
                          )

