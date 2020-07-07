USE PIMSV2
Go
Set Statistics IO ON
Set Statistics TIME ON

--Exec dbo.COP_ProcLogic
--GO
--Exec dbo.COP_ProcLogic_2
--GO

Drop Proc If Exists dbo.COP_ProcLogic_2
GO
/***************************************************************************************
▒ 시스템 상세		: COP_ProcLogic_2
▒ 주의/참고사항	: COP
--**************************************************************************************/
CREATE Proc dbo.COP_ProcLogic_2
AS
Begin
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	Declare @ServiceInfo Table(
		UnivServiceId Int,
		ServiceName VarChar(100)
	)

	Insert Into @ServiceInfo
	Select
		UnivServiceId,
		ServiceName
	From dbo.UnivService_Info
	where UnivID = 4084


	Select
		UnivServiceId
		, SelectionId
		, RecruitTimeCode
		, RecruitTimeName
		, GroupCode
		, GroupName
		, SelectionCode
		, SelectionName
	From dbo.UnivService_SelectionInfo
	--Where UnivServiceID IN (408401, ~~~~ 408499)
	where UnivServiceID IN (Select UnivServiceId From @ServiceInfo)
	
	
	Select
		UnivServiceId
		, MajorId
		, CampusCode
		, CampusName
		, CollegeCode
		, CollegeName
		, MajorCode
		, MajorName
		, SubMajorCode
		, SubMajorName
	From dbo.UnivService_MajorInfo
	where UnivServiceID IN (Select UnivServiceId From @ServiceInfo)
	

	Select
		SRSID,
		SelectionId,
		MajorId,
		RegistStatus
	From dbo.Stu_CommonInfo
	where UnivServiceID IN (Select UnivServiceId From @ServiceInfo)
	And PassStatus = 1
	
	Select 
		UnivServiceId,
		ServiceName
	From @ServiceInfo

End
GO