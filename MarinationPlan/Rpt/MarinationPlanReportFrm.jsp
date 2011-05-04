<jsp:include page = '/Include/ValidateSessionYum.jsp'/>

<%--
##########################################################################################################
# Nombre Archivo  : MarinationPlanReportFrm.jsp
# Compania        : Yum Brands Intl
# Autor           : Sergio Cuellar
# Objetivo        : Tablas en excel muy chafa proporcionado por operaciones de planeacion de marinado
# Fecha Creacion  : 18/Enero/2011
##########################################################################################################
--%>

<%@ page import="java.util.*" %>
<%@ page import="java.io.File"%>
<%@ page import="generals.*" %>
<%@ include file="/Include/CommonLibYum.jsp" %>

<%! 
	AbcUtils moAbcUtils = new AbcUtils();
	String msYear;
	String msPeriod;
	String msWeek;
	String msDay;
	String msTarget;
	String msCSS;
%>

<%
	try
	{
		msYear   = request.getParameter("year");
		msPeriod = request.getParameter("period");
		msWeek   = request.getParameter("week");
		msDay    = request.getParameter("day");
		msTarget = request.getParameter("hidTarget");

	}
	catch(Exception e)
	{
		msYear   = "0";
		msPeriod = "0";
		msWeek   = "0";
	}
	
	if(msTarget.equals("Printer"))
	{
		msCSS = "../CSS/DataGridReportPrinterYum.css";
	}
	else
	{
		msCSS = "/CSS/DataGridDefaultYum.css";
	}
%>

<html>
    <head>
        <link rel="stylesheet" type="text/css" href="/CSS/GeneralStandardsYum.css"/>
        <script src="/Scripts/ArrayUtilsYum.js"></script>
        <script src="/Scripts/DataGridClassYum.js"></script>
        <script src="/Scripts/MiscLibYum.js"></script>
        <script src="/Scripts/StringUtilsYum.js"></script>
        <script src="/Scripts/HtmlUtilsYum.js"></script>
	<script>
		var reportOk = true;
 		function submitFrame(frameName)
            	{
                	document.mainform.target = frameName;

                	if(frameName=='preview')
                    		document.mainform.hidTarget.value = "Preview";

                	if(frameName=='printer')
                    		document.mainform.hidTarget.value = "Printer";

                	document.mainform.submit();
            	}
		function submitFrames()
            	{
                	setTimeout("submitFrame('printer')", 1000);
                	//Despues de 2 seg se carga el segundo frame
                	setTimeout("submitFrame('preview')", 3000);
            	}
		function doAction()
            	{

                	if(reportOk == true)
                	{
                    		submitFrames();
                	}
                	else
                	{
                    		document.mainform.action = '/MessageYum.jsp';
                    		addHidden(document.mainform, 'hidTitle', 'Marinado y ajuste de marinado');
                    		addHidden(document.mainform, 'hidSplit', 'true');
                   	 	submitFrame('preview');
                	}
            	}
	</script>
    </head>

    <body bgcolor="white" style="margin-left: 0px; margin-right: 0px" 
          onLoad="doAction()">

    <jsp:include page="/Include/GenerateHeaderYum.jsp">
		<jsp:param name="psStoreName" value="true"/>
    </jsp:include>

    <table width="99%" border="0" align="center" cellspacing="6">
        <tr>
			<td>
				<b class="datagrid-leyend">A&ntilde;o: <%= msYear %>, Periodo: <%= msPeriod %>, Semana: <%= msWeek %></b>
            </td>
        </tr>
        <tr>
            <td>
		<center><p><a class="datagrid-leyend" href=marinado.sxc>Descargar archivo de Marinado en Excel para el d&iacute;a <%= msDay %> de la semana   <%= msWeek %> periodo <%= msPeriod %> del a&ntilde;o <%= msYear %></a></p></center>
                <br>
            </td>
	</tr>
	<tr>
	    <td>
	    	<div id="goDataGrid"></div>
	       <% String directoryName = "/usr/local/tomcat/webapps/ROOT/Planning/MarinationPlan/Rpt";
	          File directory = new File(directoryName);
		  File[] fileList = directory.listFiles();
		  Arrays.sort(fileList);
		  for (int i = 0; i < fileList.length; i++) {
		  	File file = fileList[i];
			String name = file.getName();
			int dotIndex = name.indexOf('.');
			String fileName = name.substring(0, dotIndex);
			String fileType = name.substring(dotIndex+1).toLowerCase();
			if(fileType.equals("html")) {
			System.out.println("nombre archivo: "+ name);
	       		%>
			<jsp:include page = '<%= name %>' />
			<% 
			}
		  }
	       %>
	    </td>
        </tr>
    </table>

    <jsp:include page = '/Include/TerminatePageYum.jsp'/>
    </body>
</html>
