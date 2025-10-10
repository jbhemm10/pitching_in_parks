"""
This file is going to be used to collect pitching data for a later project.

INPUTS: 
- statcast data from pybaseball
OUTPUTS:
- data files containing pitch outcomes for each MLB stadium
"""
import pandas as pd
import pybaseball
from pybaseball import statcast
import datetime
from datetime import date


# Collect stadium and team information
stadium_data = pd.read_csv('input_tables/MLB_Stadium_Info.csv')

teams = stadium_data['team_name'].tolist()
abbreviations = stadium_data['abbreviation'].tolist()
venues = stadium_data['venue_name'].tolist()

user_input = input("Enter the team abbreviation (e.g., 'NYY' for New York Yankees): ").upper()
while user_input not in abbreviations:
    # User doesn't enter a valid abbreviation
    print("Invalid abbreviation. Here are the valid options:", abbreviations)
    user_input = input("Please enter a valid team abbreviation: ").upper()
else:
    index = abbreviations.index(user_input)
    stadium_name = venues[index]
    team_name = teams[index]
    print(f"The stadium name for the {team_name} ({user_input}) is {stadium_name}.")

# Ask user what year they want data for 
year_input = input("Enter the year you want data for (e.g., '2023'): ")
while not year_input.isdigit() or int(year_input) < 1962 or int(year_input) > date.today().year:
    print("Invalid year. Please enter a year between 1962 and 2024.")
    year_input = input("Enter the year you want data for (e.g., '2023'): ")
    print(f"You entered: {year_input}")


# Collect data for the specified year
year_input = int(year_input)
print(f"Collecting data for the year {year_input} and stadium {stadium_name}...")
pybaseball.cache.enable()
data_year = statcast(start_dt=f'{year_input}-03-26', end_dt=f'{year_input}-10-01')

'''
# Filter data for the specified stadium
data_year_stadium = data_year[data_year['home_team'] == user_input]
'''

# Remove any rows with missing values in pitch_type
data_year= data_year.dropna(subset=['pitch_type'])


# Keep designated columsn
cols_to_keep = ['pitch_type', 'game_date', 'release_speed', 'release_pos_x', 'release_pos_z', 
                'player_name', 'batter', 'pitcher', 'events', 'description', 
                'zone', 'stand', 'p_throws', 'inning', 'inning_topbot', 'pitch_number', 'balls', 
                'strikes','home_team', 'away_team', 'hit_location', 'hit_distance_sc', 'launch_speed',
                'launch_angle', 'estimated_woba_using_speedangle', 'woba_value', 'babip_value',
                'iso_value', 'estimated_slg_using_speedangle',  'bb_type', 'game_year']

data_year = data_year[cols_to_keep]

# Add id column to help SQL
data_year.insert(0, 'id', range(1, 1 + len(data_year)))

# Save to csv
data_year.to_csv(f'input_tables/{year_input}_pitch_by_pitch_data.csv', index=False)

# Count how many fast

