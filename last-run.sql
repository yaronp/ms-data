CREATE OR ALTER PROCEDURE Last_run 
AS
    DECLARE @LastRun INT
    SET @LastRun = (select Max(RunNumber) from MachineScoreEventTops)

    select * from MachineScoreEventTops
        INNER JOIN MachineScoreEvents MSE on MachineScoreEventTops.EventId = MSE.EventId
    WHERE MachineScoreEventTops.RunNumber = @LastRun