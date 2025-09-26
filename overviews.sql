-- Collects all pitch types at each stadium and counts them
SELECT
    home_team as stadium, 
    pitch_type, 
    COUNT(*) AS total_pitches
from dbo.[2024_pitch_by_pitch_data]
GROUP BY home_team, pitch_type
ORDER BY home_team, total_pitches DESC;

-- Collects and counts all pitch types thrown regardless of stadium
SELECT 
    pitch_type, 
    COUNT(*) AS total_pitches
from dbo.[2024_pitch_by_pitch_data]
GROUP BY pitch_type
ORDER BY total_pitches DESC;

-- Collects all pitch types at each stadium and counts them, with strike/ball/in play breakdown
SELECT 
    p.home_team as venue_abbreviation,
    s.venue_name,
    p.pitch_type,
    pa.pitch_name,
    COUNT(*) AS total_pitches,
    COUNT(CASE WHEN p.description = 'called_strike' OR p.description = 'swinging_strike' or p.description = 'foul' OR p.description = 'foul_tip' or p.description = 'foul_bunt' or p.description = 'missed_bunt' THEN 1 END) AS strike_count,
    COUNT(CASE WHEN p.description = 'ball' or p.description = 'blocked_ball' or p.description = 'hit_by_pitch' THEN 1 END) AS ball_count,
    COUNT(CASE WHEN p.description = 'hit_into_play' THEN 1 END) AS in_play_count,
    COUNT(CASE WHEN p.events = 'single' THEN 1 END) AS single_count,
    COUNT(CASE WHEN p.events = 'double' THEN 1 END) AS double_count,
    COUNT(CASE WHEN p.events = 'triple' THEN 1 END) AS triple_count,
    COUNT(CASE WHEN p.events = 'home_run' THEN 1 END) AS home_run_count,
    COUNT(CASE WHEN p.events = 'sac_fly' THEN 1 END) AS sac_fly_count,
    COUNT(CASE WHEN p.events = 'sac_bunt' THEN 1 END) AS sac_bunt_count,
    COUNT(CASE WHEN p.events = 'field_out' THEN 1 END) AS field_out_count,
    COUNT(CASE WHEN p.events = 'force_out' THEN 1 END) AS force_out_count,
    COUNT(CASE WHEN p.events = 'fielders_choice' THEN 1 END) AS fielders_choice_count,
    COUNT(CASE WHEN p.events = 'fielders_choice_out' THEN 1 END) AS fielders_choice_out_count,
    COUNT(CASE WHEN p.events = 'grounded_into_double_play' THEN 1 END) AS gidp_count,
    COUNT(CASE WHEN p.events = 'double_play' THEN 1 END) AS double_play_count,
    COUNT(CASE WHEN p.events = 'field_error' THEN 1 END) AS error_count  
FROM dbo.[2024_pitch_by_pitch_data] p
INNER JOIN dbo.pitch_abbreviations pa
    ON p.pitch_type = pa.pitch_abbreviation
INNER JOIN dbo.stadium_info s
    ON p.home_team = s.abbreviation
GROUP BY p.home_team, s.venue_name, p.pitch_type, pa.pitch_name
ORDER BY p.home_team, total_pitches DESC;


-- Join pitch data with full name for pitches
SELECT 
p.home_team as stadium,
p.pitch_type,
pa.pitch_name,
COUNT(*) AS total_pitches
FROM dbo.[2024_pitch_by_pitch_data] p
INNER JOIN dbo.pitch_abbreviations pa
    ON p.pitch_type = pa.pitch_abbreviation
GROUP BY p.home_team, p.pitch_type, pa.pitch_name
ORDER BY p.home_team, total_pitches DESC;