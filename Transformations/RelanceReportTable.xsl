<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="html" doctype-public="XSLT-compat" encoding="UTF-8"/>
	<xsl:template match="/">
		<html>
			<head>
				<style>
        
          body {
            font-family: Arial, sans-serif;
			 background-color: #EBF4F6;
          }

          h1{
            text-align: center;
            color: #7D8585;
          }
		   

          table {
            border-collapse: collapse;
            margin: 20px auto;
            width: 80%;
            border: 1px solid #66B5B3;
            border-radius: 10px;
            overflow: hidden;
			
          }

          th, td {
            border: 1px solid #66B5B3;
            padding: 10px;
            text-align: left;
          }

          th {
            background-color: #66B5B3;
            color: white;
          }

          tr:nth-child(even) {
            background-color: #f2f2f2;
          }
		   tr:last-child td {
            border-bottom: 3px solid #66B5B3;
          }


          tr:hover {
            background-color: #e0f7fa;
          }
  </style>
			</head>
			<body>
				<h1>Relance Actions Report</h1>
				<table>
					<tr>
						<th>Provider Name</th>
						<th>Email</th>
						<th>Company Name</th>
						<th>Service Count</th>
						<th>Scheduled Services</th>
						<th>Days Since Scheduled</th>
						<th>Relance Action</th>
					</tr>
					<xsl:for-each select="ManagementSystem/Users/AssistanceSeeker/HealthProviders">
						<tr>
							<!-- Provider Name and Email -->
							<td>
								<xsl:value-of select="providerInfos/Name"/>
							</td>
							<td>
								<xsl:value-of select="providerInfos/Email"/>
							</td>
							<!-- Company Name or N/A if working alone -->
							<td>
								<xsl:choose>
									<xsl:when test="TypeOfHealthProviders/ServiceCompanies">
										<xsl:value-of select="TypeOfHealthProviders/ServiceCompanies/CompanieInfos/Name"/>
									</xsl:when>
									<xsl:otherwise>N/A</xsl:otherwise>
								</xsl:choose>
							</td>
							<!-- Service Count -->
							<td>
								<xsl:value-of select="count(../Services/*[ServiceInfos/ProviderID = current()/ProviderID])"/>
							</td>
							<!-- Scheduled Services -->
							<td>
								<xsl:for-each select="../Services/*[ServiceInfos/ProviderID = current()/ProviderID]">
									<xsl:value-of select="ServiceInfos/ServiceID"/>: 
              <xsl:value-of select="SCHEDULING"/>
									<br/>
								</xsl:for-each>
							</td>
							<!-- Days Since Scheduled -->
							<td>
								<!-- Loop through Services and calculate days from scheduling -->
								<xsl:for-each select="../Services/*[ServiceInfos/ProviderID = current()/ProviderID]">
									<xsl:variable name="scheduledDate" select="SCHEDULING"/>
									<!-- Calculate days since scheduling -->
									<xsl:variable name="daysSinceScheduled" select="days-from-duration(current-date() - xs:date($scheduledDate))"/>
									<xsl:value-of select="$daysSinceScheduled"/>
									<br/>
								</xsl:for-each>
							</td>
							<!-- Relance Action -->
							<td>
								<!-- Loop through Services and calculate relance based on scheduled date -->
								<xsl:for-each select="../Services/*[ServiceInfos/ProviderID = current()/ProviderID]">
									<xsl:variable name="scheduledDate" select="SCHEDULING"/>
									<!-- Calculate days since scheduling -->
									<xsl:variable name="daysSinceScheduled" select="days-from-duration(current-date() - xs:date($scheduledDate))"/>
									<xsl:choose>
										<xsl:when test="number($daysSinceScheduled) > 120">Relance/Reschedule</xsl:when>
										<xsl:otherwise>No Relance</xsl:otherwise>
									</xsl:choose>
									<br/>
								</xsl:for-each>
							</td>
						</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
