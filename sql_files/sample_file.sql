-- Example of query finding sliders at Rate field, used for digging into data
SELECT * from dbo.[2024_pitch_by_pitch_data]
where pitch_type = 'SL' and home_team = 'CWS'