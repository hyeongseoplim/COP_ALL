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
	Where UnivServiceID = 408401
	
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
	Where UnivServiceID = 408401


	Select
		SRSID,
		SelectionId,
		MajorId,
		RegistStatus
	From dbo.Stu_CommonInfo
	Where UnivServiceID = 408401
	And PassStatus = 1

End
GO