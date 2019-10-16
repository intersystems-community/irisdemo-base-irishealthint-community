Class IRISDemo.Util.ContextSearch Extends %ZEN.Portal.ContextSearch
{
	ClassMethod LookupTableDownloadItems(Output pCaption As %String, Output pTopResults, Output pResults, ByRef pParms As %String, pSearchKey As %String = "") As %Status
	{
		Set pParms("className")="IRISDemo.BO.LookupTable.Operation"
		Quit ##class(Ens.ContextSearch).ProductionItems(.pCaption, .pTopResults, .pResults, .pParms, .pSearchKey)
	}
}
