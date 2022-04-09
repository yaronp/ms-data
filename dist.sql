DECLARE @score INT
DECLARE @group NVARCHAR(100)

DECLARE @score1 INT
DECLARE @group1 NVARCHAR(100)

DECLARE @LastRun INT
SET @LastRun = (select Max(RunNumber) from MachineScoreEventTops)
@LastRun + 1 


DECLARE @Max_Scores_By_Groups CURSOR
SET @Max_Scores_By_Groups = CURSOR FOR
    SELECT maxes.score, maxes.MachineGroup
        FROM  (select max(Score) as score, MachineGroup as MachineGroup from MachineScoreEvents group by MachineGroup) maxes
        WHERE (MachineScoreEvents.EventId NOT IN (SELECT EventId from MachineScoreEventTops where MachineScoreEventTops.EventId = MachineScoreEvents.EventId))

OPEN @Max_Scores_By_Groups
FETCH NEXT FROM @Max_Scores_By_Groups INTO @score, @group
WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO MachineScoreEventTops (Score, MachineGroup, MachineId, ReportTime, RunNumber)
        SELECT Score, MachineGroup, MachineId, ReportTime, @LastRun FROM MachineScoreEvents WHERE (MachineGroup = @group AND Score = @score)
    SET @group1 = null
    FETCH NEXT FROM @Max_Scores_By_Groups INTO @score, @group
END

CLOSE @Max_Scores_By_Groups
DEALLOCATE @Max_Scores_By_Groups

GO
