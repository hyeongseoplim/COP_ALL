
USE PIMSV2
Go
Set Statistics IO ON
Set Statistics TIME ON

Drop Proc If Exists dbo.COP_ProcLogic_1
GO
/***************************************************************************************
▒ 시스템 상세		: COP_ProcLogic
▒ 주의/참고사항	: COP
--**************************************************************************************/
CREATE Proc dbo.COP_ProcLogic_1
	@UnivServiceId Int = 408401
	, @StartDate DateTime = '2019-12-01'
	, @EndDate DateTime = '2019-12-31'
AS
Begin
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	Select
		UnivServiceId,
		ServiceName
	From dbo.UnivService_Info
	where UnivID = 4084

	Select 
		UMI.MajorCode
		, UMI.MajorName
		--10	일반전형	I
		--24	특별(일반과정)	I
		--13	특별(전문직업과정)	I
		, Sum(Case When USI.SelectionCode = '10' And SP.PayStatus is not null Then 1 Else 0 End) [일반전형_등록자]
		, Sum(Case When USI.SelectionCode = '10' And SP.PayStatus is null Then 1 Else 0 End) [일반전형_미등록자]
		, Sum(Case When USI.SelectionCode = '24' And SP.PayStatus is not null Then 1 Else 0 End) [특별(일반과정)_등록자]
		, Sum(Case When USI.SelectionCode = '24' And SP.PayStatus is null Then 1 Else 0 End) [특별(일반과정)_미등록자]
		, Sum(Case When USI.SelectionCode = '13' And SP.PayStatus is not null Then 1 Else 0 End) [특별(전문직업과정)_등록자]
		, Sum(Case When USI.SelectionCode = '13' And SP.PayStatus is null Then 1 Else 0 End) [특별(전문직업과정)_미등록자]

		--20	대졸자	O
		--52	농어촌	O
		--54	기초생활차상위계층	O
		--57	북한이탈주민	O
		, Sum(Case When USI.SelectionCode = '20' And SP.PayStatus is not null Then 1 Else 0 End) [대졸자_등록자]
		, Sum(Case When USI.SelectionCode = '20' And SP.PayStatus is null Then 1 Else 0 End) [대졸자_미등록자]
		, Sum(Case When USI.SelectionCode = '52' And SP.PayStatus is not null Then 1 Else 0 End) [농어촌_등록자]
		, Sum(Case When USI.SelectionCode = '52' And SP.PayStatus is null Then 1 Else 0 End) [농어촌_미등록자]
		, Sum(Case When USI.SelectionCode = '54' And SP.PayStatus is not null Then 1 Else 0 End) [기초생활차상위계층_등록자]
		, Sum(Case When USI.SelectionCode = '54' And SP.PayStatus is null Then 1 Else 0 End) [기초생활차상위계층_미등록자]
		, Sum(Case When USI.SelectionCode = '57' And SP.PayStatus is not null Then 1 Else 0 End) [북한이탈주민_등록자]
		, Sum(Case When USI.SelectionCode = '57' And SP.PayStatus is null Then 1 Else 0 End) [북한이탈주민_미등록자]

	From dbo.Stu_CommonInfo Stu
	Inner Join dbo.UnivService_SelectionInfo USI On Stu.SelectionId = USI.SelectionId
	Inner Join dbo.UnivService_MajorInfo UMI On Stu.MajorId = UMI.MajorId
	Left Outer Join dbo.Stu_PayInfo SP On Stu.SRSID = SP.SRSID
		And SP.PayDate >= @StartDate
		And SP.PayDate <= @EndDate
		--And SP.PayDate BetWeen @StartDate And @EndDate
	Where Stu.UnivServiceID = @UnivServiceId
	And Stu.PassStatus = 1
	Group By UMI.MajorCode
		, UMI.MajorName

	/*
	Select 
		UMI.MajorCode
		, UMI.MajorName
		--10	일반전형	I
		--24	특별(일반과정)	I
		--13	특별(전문직업과정)	I
		, Sum(Case When USI.SelectionCode = '10' And Stu.RegistStatus = 1 Then 1 Else 0 End) [일반전형_등록자]
		, Sum(Case When USI.SelectionCode = '10' And Stu.RegistStatus = 0 Then 1 Else 0 End) [일반전형_미등록자]
		, Sum(Case When USI.SelectionCode = '24' And Stu.RegistStatus = 1 Then 1 Else 0 End) [특별(일반과정)_등록자]
		, Sum(Case When USI.SelectionCode = '24' And Stu.RegistStatus = 0 Then 1 Else 0 End) [특별(일반과정)_미등록자]
		, Sum(Case When USI.SelectionCode = '13' And Stu.RegistStatus = 1 Then 1 Else 0 End) [특별(전문직업과정)_등록자]
		, Sum(Case When USI.SelectionCode = '13' And Stu.RegistStatus = 0 Then 1 Else 0 End) [특별(전문직업과정)_미등록자]

		--20	대졸자	O
		--52	농어촌	O
		--54	기초생활차상위계층	O
		--57	북한이탈주민	O
		, Sum(Case When USI.SelectionCode = '20' And Stu.RegistStatus = 1 Then 1 Else 0 End) [대졸자_등록자]
		, Sum(Case When USI.SelectionCode = '20' And Stu.RegistStatus = 0 Then 1 Else 0 End) [대졸자_미등록자]
		, Sum(Case When USI.SelectionCode = '52' And Stu.RegistStatus = 1 Then 1 Else 0 End) [농어촌_등록자]
		, Sum(Case When USI.SelectionCode = '52' And Stu.RegistStatus = 0 Then 1 Else 0 End) [농어촌_미등록자]
		, Sum(Case When USI.SelectionCode = '54' And Stu.RegistStatus = 1 Then 1 Else 0 End) [기초생활차상위계층_등록자]
		, Sum(Case When USI.SelectionCode = '54' And Stu.RegistStatus = 0 Then 1 Else 0 End) [기초생활차상위계층_미등록자]
		, Sum(Case When USI.SelectionCode = '57' And Stu.RegistStatus = 1 Then 1 Else 0 End) [북한이탈주민_등록자]
		, Sum(Case When USI.SelectionCode = '57' And Stu.RegistStatus = 0 Then 1 Else 0 End) [북한이탈주민_미등록자]

	From dbo.Stu_CommonInfo Stu
	Inner Join dbo.Stu_PayInfo SP On Stu.SRSID = SP.SRSID
	Inner Join dbo.UnivService_SelectionInfo USI On Stu.SelectionId = USI.SelectionId
	Inner Join dbo.UnivService_MajorInfo UMI On Stu.MajorId = UMI.MajorId
	Where Stu.UnivServiceID = @UnivServiceId
	And SP.PayDate >= @StartDate
	And SP.PayDate <= @EndDate
	--And SP.PayDate BetWeen @StartDate And @EndDate
	And Stu.PassStatus = 1
	Group By UMI.MajorCode
		, UMI.MajorName
	*/

End
GO