
DECLARE @counter BIGINT, @groupCounter SMALLINT
SET @groupCounter=0
SET @counter=0

DECLARE @maxval DECIMAL(6,5), @minval DECIMAL(6,5)
SELECT @maxval=1.000,@minval=0.000

DECLARE @t DATETIME

WHILE @groupCounter < 100
BEGIN
	SET @groupCounter = @groupCounter + 1
	SET @counter=0
	WHILE @counter < 10000
	BEGIN
		SET @counter = @counter + 1
        SET @t = (SELECT CAST(CAST(DATEADD(second,0,GETDATE()) AS INT) + CAST(((@maxval) - @minval) * RAND(CHECKSUM(NEWID())) + @minval AS DECIMAL(6,5)) AS DATETIME))
        INSERT INTO "MachineScoreEvents" (MachineId, Score, MachineGroup, ReportTime   ) VALUES (NEWID(), FLOOR(RAND()*(100))+1 ,@groupCounter, @t)
	END
END



