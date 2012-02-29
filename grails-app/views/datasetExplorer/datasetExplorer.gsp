<%@ page language="java" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<title>Dataset Explorer</title>

<LINK REL="SHORTCUT ICON"
	HREF="${resource(dir:'images', file:'i2b2_hive.ico')}">
<LINK REL="ICON"
	HREF="${resource(dir:'images', file:'i2b2_hive.ico')}">

<!-- Include Ext and app-specific scripts: -->
<script type="text/javascript"
	src="${resource(dir:'js/sarissa', file:'sarissa.js')}"></script>
<script type="text/javascript"
	src="${resource(dir:'js/sarissa', file: 'sarissa_ieemu_xpath.js')}"></script>
<script type="text/javascript"
	src="${resource(dir:'js/javeline', file: 'javeline_xpath.js')}"></script>
<g:javascript library="prototype" />
<script type="text/javascript"
	src="${resource(dir:'js', file:'ext/adapter/ext/ext-base.js')}"></script>
<script type="text/javascript"
	src="${resource(dir:'js', file:'ext/ext-all.js')}"></script>
<script type="text/javascript"
	src="${resource(dir:'js/ext-ux', file:'miframe.js')}"></script>
<script type="text/javascript" src="${resource(dir:'js/datasetExplorer', file:'i2b2common.js')}"></script>
<!-- <script type="text/javascript" src="${resource(dir:'js/datasetExplorer', file:'dataAssociation.js')}"></script> -->
<script type="text/javascript"
	src="${resource(dir:'js/datasetExplorer', file: 'requests.js')}"></script>
<script type="text/javascript"
	src="${resource(dir:'js/datasetExplorer', file: 'ext-i2b2.js')}"></script>
<script type="text/javascript" src="${resource(dir:'js', file:'myJobs.js')}"></script>

<script type="text/javascript"
	src="${resource(dir:'js/datasetExplorer/exportData', file: 'dataTab.js')}"></script>
<script type="text/javascript"
	src="${resource(dir:'js/datasetExplorer/exportData', file: 'exportJobsTab.js')}"></script>
<!-- <script type="text/javascript" src="http://www.google.com/jsapi"></script>
<script type="text/javascript">
	google.load("visualization", "1", {});
</script>
 <script type="text/javascript"	src="${resource(dir:'js', file:'bioheatmap.js')}"></script>-->
	
	<!-- Include Ext stylesheets here: -->
	<link rel="stylesheet" type="text/css" href="${resource(dir:'js/ext/resources/css', file:'ext-all.css')}">
	<link rel="stylesheet" type="text/css" href="${resource(dir:'js/ext/resources/css', file:'xtheme-gray.css')}">
	<link rel="stylesheet" type="text/css" href="${resource(dir:'css', file:'datasetExplorer.css')}">
	
	<script type="text/javascript" src="${resource(dir:'js/datasetExplorer', file:'datasetExplorer.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'js', file:'browserDetect.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'js', file:'advancedWorkflowFunctions.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'js/plugin', file:'SurvivalAnalysis.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'js/plugin', file:'LineGraph.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'js/plugin', file:'CorrelationAnalysis.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'js/plugin', file:'ScatterPlot.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'js/datasetExplorer', file:'dataAssociation.js')}"></script>
	<script type="text/javascript" src="${resource(dir:'js', file:'utilitiesMenu.js')}"></script>
</head>

<body>
 
<script type="text/javascript">
	Ext.BLANK_IMAGE_URL = "${resource(dir:'js', file:'ext/resources/images/default/s.gif')}";

	//set ajax to 600*1000 milliseconds
	Ext.Ajax.timeout = 1800000;

	// this overrides the above
	Ext.Updater.defaults.timeout = 1800000;

	var pageInfo = {
		basePath :"${request.getContextPath()}"
	}
	/******************************************************************************/
	//Global Variables
	GLOBAL = {
	  Version : '1.0',
	  Domain: '${i2b2Domain}',
	  ProjectID: '${i2b2ProjectID}',
	  Username: '${i2b2Username}',
	  Password: '${i2b2Password}',
	  AutoLogin: true,
	  Debug: false,
	  NumOfSubsets: 2,
	  NumOfQueryCriteriaGroups:20,
	  NumOfQueryCriteriaGroupsAtStart:3,
	  MaxSearchResults: 100,
	  PMUrl: '${grailsApplication.config.com.recomdata.datasetExplorer.pmServiceURL}',
	  PMTransport: 'rest',
	  PMproxy:${grailsApplication.config.com.recomdata.datasetExplorer.pmServiceProxy},
	  CRCUrl: '',
	  ONTUrl: '',
	  Config:'jj',
	  CurrentQueryName:'',
	  CurrentComparisonName:' ',
	  CurrentSubsetIDs: new Array(),
	  CurrentPathway: '',
	  CurrentGenes: '',
	  CurrentChroms: '',
	  CurrentDataType: '',
	  GPURL: '${grailsApplication.config.com.recomdata.datasetExplorer.genePatternURL}',
	  HeatmapType: 'Compare',
	  IsAdmin: ${admin},
	  Tokens: "${tokens}",
	  InitialSecurity: ${initialaccess},
	  RestoreComparison: ${restorecomparison},
	  RestoreQID1: "${qid1}",
	  RestoreQID2: "${qid2}",
	  resulttype: 'applet',
	  searchType: "${grailsApplication.config.com.recomdata.search.genepathway}",
	  DefaultCohortInfo: '',
	  CurrentTimepoints: new Array(),
	  CurrentSamples: new Array(),
	  CurrentPlatforms: new Array(),
	  CurrentGpls: new Array(),
	  CurrentTissues: new Array(),
	  CurrentRbmpanels: new Array(),
	  PathToExpand: "${pathToExpand}",
	  preloadStudy: "${params.DataSetName}",
	  Binning: false,
	  ManualBinning: false,
	  NumberOfBins: 4,
	  HelpURL: '${grailsApplication.config.com.recomdata.searchtool.adminHelpURL}',
	  ContactUs: '${grailsApplication.config.com.recomdata.searchtool.contactUs}',
	  AppTitle: '${grailsApplication.config.com.recomdata.searchtool.appTitle}',
      BuildVersion: 'Build Version: <g:meta name="environment.BUILD_NUMBER"/> - <g:meta name="environment.BUILD_ID"/>',
	  AnalysisRun: false,
	  basePath: pageInfo.basePath
	};
	// initialize browser version variables; see http://www.quirksmode.org/js/detect.html
	BrowserDetect.init();
	if (BrowserDetect.browser == "Explorer"){

	    if(BrowserDetect.version < 7) {
			GLOBAL.resulttype = 'image';
		}
	}
</script>
<div id="header-div"><g:render template="/layouts/commonheader" model="['app':'datasetExplorer']" /></div>
<div id="main"></div>
<h3 id="test">Loading....</h3>
<g:form name="exportdsform" controller="export" action="exportDataset"/>
<g:form name="exportgridform" controller="chart" action="exportGrid" />
	<IFRAME src="${grailsApplication.config.com.recomdata.datasetExplorer.genePatternURL}/gp/logout" width="1" height="1" scrolling="no" frameborder="0" id="gplogin"></IFRAME>
	<IFRAME src="${grailsApplication.config.com.recomdata.datasetExplorer.genePatternURL}/gp/logout" width="1" height="1" scrolling="no" frameborder="0" id="altgplogin"></IFRAME>
	<span id="visualizerSpan0"></span> <!-- place applet tag here -->
	<span id="visualizerSpan1"></span> <!-- place applet tag here -->
<!-- ************************************** -->
	<!-- This implements the Help functionality -->
	<script type="text/javascript" src="${resource(dir:'js', file:'help/D2H_ctxt.js')}"></script>
	<script language="javascript">
		helpURL = '${grailsApplication.config.com.recomdata.searchtool.adminHelpURL}';
	</script>
<!-- ************************************** --> 
</body>
</html>