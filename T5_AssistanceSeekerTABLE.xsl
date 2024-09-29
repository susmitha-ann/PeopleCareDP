<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">

  
  <xsl:output method="html" doctype-public="XSLT-compat" encoding="UTF-8"/>

  <xsl:template match="/">
    <html>
	<head>
	<title>Asisstance Seeker Sorted</title>
	<style>
	 table {
    border-collapse: collapse;
    width: 65%; 
    margin: 20px auto;
    background-color: white;
    border-radius: 10px;
    border: 2px solid #06068F;
  }

  th {
    background-color: #06068F;
    color: white;
    padding: 10px;
    text-align: center;
  }

  td {
    background-color: #f2f2f2;
    padding: 8px;
    text-align: center;
  }


  tr:nth-child(even) td {
    background-color: #d9e1f2;
  }

 h2{ text-align:center ; margin-top: 20px; margin-bottom:20px}
  tr:hover td {
    background-color: #5C6B9C;
    color: white;
  }
	</style>
	</head>
      <body>
        <h2>Assistance Seeker Informations</h2>
        <table>
          <tr>
            <th>Name</th>
            <th>Gender</th>
            <th>Age</th>
            <th>Service</th>
            <th>Occurrence</th>
            <th>Participation Year</th>
            <th>Action</th>
          </tr>

          <!-- Loop through each AssistanceSeeker and sort them by Name using variables to store their values for future use -->
          <xsl:for-each select="//AssistanceSeeker">
            <xsl:sort select="contactInfos/Name" order="ascending" />

            <xsl:variable name="seekerName" select="contactInfos/Name"/>
            <xsl:variable name="seekerGender" select="gender"/>
            <xsl:variable name="seekerAge" select="age"/>
            
            <!-- Looping through each service in UserParticipation -->
            <xsl:for-each select="UserParticipation/entry">
              <!-- Matching the service ID from UserParticipation to Services -->
              <xsl:variable name="serviceID" select="ServiceID"/>
              <xsl:variable name="service" select="../../Services/*[ServiceInfos/ServiceID = $serviceID]"/>
              <xsl:variable name="occurrence" select="$service/@occurrence"/>

              <!-- Extract the year from ParticipationDateForServices -->
             <!-- Retrieve the most recent ParticipationDateForServices using last() and removing serviceID from the filtering, we can have multiple ParticipationDateForServices -->
              <xsl:variable name="mostRecentDate" select="(ParticipationDateForServices)[last()]"/>
              <xsl:variable name="participationYear" select="fn:year-from-date($mostRecentDate)"/>

             <!-- to decide if we archive based on the year -->
              <xsl:variable name="action">
                <xsl:choose>
                  <xsl:when test="$participationYear &lt;= 2023">Archive</xsl:when>
                  <xsl:otherwise>In Progress</xsl:otherwise> 
                </xsl:choose>
              </xsl:variable>
			  
              <!-- Display rows in the table using variables already prepared -->
              <tr>
                <td><xsl:value-of select="$seekerName"/></td>
                <td><xsl:value-of select="$seekerGender"/></td>
                <td><xsl:value-of select="$seekerAge"/></td>
                <td><xsl:value-of select="$service/$serviceID"/></td>
                <td><xsl:value-of select="$occurrence"/></td>
                <td><xsl:value-of select="$participationYear"/></td>
				 <td><xsl:value-of select="$action"/></td>
              </tr>
			 
            </xsl:for-each>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
