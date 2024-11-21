### Script to prepare the dataset for the database of hattrick players ###
## The overall aim is to create a normalized relational database ##
# www.hattrick.org #


# Import of nessesary libraries

import pandas as pd




# Loading the data (players are not older than 30 years old and without goalkeepers) as csv's into dataframes
# Attention: The csv's have a problem with the column 'Verletzungen ': the empty-space needs to be deleted 

df = pd.read_csv('transferresultsplayers_1.csv', sep=',') 
df2 = pd.read_csv('transferresultsplayers_2.csv', sep=',')
df3 = pd.read_csv('transferresultsplayers_3.csv', sep=',')
df4 = pd.read_csv('transferresultsplayers_4.csv', sep=',')
df5 = pd.read_csv('transferresultsplayers_5.csv', sep=',')
df6 = pd.read_csv('transferresultsplayers_6.csv', sep=',')
df7 = pd.read_csv('transferresultsplayers_7.csv', sep=',')

# Concatenation of the dataframes

frames = [df, df2, df3, df4, df5, df6, df7]

filled_data = pd.concat(frames, ignore_index=True)
df = filled_data




# Filtering the columns that are to stay because of the next steps

df = df.filter(['Nationalität', 'Name', 'Spezialität', 'Verletzungen', 'Gelbe Karten', 'Alter', 'Tag(e)', 'TSI', 
                'Gehalt', 'Wochen im Verein', 'Erfahrung', 'Führungsqualitäten', 'Form', 'Kondition', 'Torwart', 
                'Verteidigung', 'Spielaufbau', 'Flügelspiel', 'Passspiel', 'Torschuss', 'Standards'], axis=1)


# Loading the data of my own team (players are not older than 30 years old and without goalkeepers)
# The csv of my own players is in a differently designed table

my_df = pd.read_csv('players_own.csv', sep=',')

# For a nice dataset I take only the columns which exist in every dataframe (Filtering)

my_df = my_df.filter(['Nationalität', 'Name', 'Spezialität', 'Verletzungen', 'Gelbe Karten', 'Alter', 'Tag(e)', 'TSI', 
                            'Gehalt', 'Wochen im Verein', 'Erfahrung', 'Führungsqualitäten', 'Form', 'Kondition', 'Torwart', 
                            'Verteidigung', 'Spielaufbau', 'Flügelspiel', 'Passspiel', 'Torschuss', 'Standards'], axis=1)


# Concatenation of the dataframes (my own players and transferresultsplayers)

frames = [df, my_df]

filled_data = pd.concat(frames, ignore_index=True)
df = filled_data




# Renaming of a column to avoid syntax-errors later

df = df.rename(columns={'Tag(e)': 'Tage'})  


# Printing the dataframe

print('Dataframe:\n', df)


# Looking for missing values in columns

print('Missing values:\n', df.isnull().sum())




# Export of the dataframe as csv

df.to_csv('all_players.csv', encoding='utf-8', index=False, header=True)


