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
    home_team as stadium,
    pitch_type,
    COUNT(*) AS total_pitches,
    COUNT(CASE WHEN description = 'called_strike' OR description = 'swinging_strike' or description = 'foul' OR description = 'foul_tip' or description = 'foul_bunt' or description = 'missed_bunt' THEN 1 END) AS strike_count,
    COUNT(CASE WHEN description = 'ball' or description = 'blocked_ball' or description = 'hit_by_pitch' THEN 1 END) AS ball_count,
    COUNT(CASE WHEN description = 'hit_into_play' THEN 1 END) AS in_play_count,
    COUNT(CASE WHEN events = 'single' THEN 1 END) AS single_count,
    COUNT(CASE WHEN events = 'double' THEN 1 END) AS double_count,
    COUNT(CASE WHEN events = 'triple' THEN 1 END) AS triple_count,
    COUNT(CASE WHEN events = 'home_run' THEN 1 END) AS home_run_count
FROM dbo.[2024_pitch_by_pitch_data]
GROUP BY home_team, pitch_type
ORDER BY home_team, total_pitches DESC;

