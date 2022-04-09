CREATE TABLE MachineScoreEvents
(
	EventId INT IDENTITY(1,1) PRIMARY KEY CLUSTERED, 
	MachineId UNIQUEIDENTIFIER, 
	Score DECIMAL(5,2), 
	MachineGroup SMALLINT, 
	ReportTime DATETIME2(7),
	CONSTRAINT CHK_MachineScoreEvents_Score CHECK (Score>=0 AND Score<=100)
) 

CREATE TABLE MachineScoreEventTops
(
	EventId INT,
	RunNumber INT
)


