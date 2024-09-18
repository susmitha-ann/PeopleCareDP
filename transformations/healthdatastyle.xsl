<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- Output as HTML -->
  <xsl:output method="html" indent="yes"/>

  <!-- Root template -->
  <xsl:template match="/ManagementSystem">
    <html>
      <head>
        <title>Health Management System</title>
        <style>
          table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
          }
          table, th, td {
            border: 1px solid black;
          }
          th, td {
            padding: 8px;
            text-align: left;
          }
          th {
            background-color: #f2f2f2;
          }
        </style>
      </head>
      <body>

        <!-- Assistance Seekers Table -->
        <h2>Assistance Seekers</h2>
        <table>
          <tr>
            <th>Seeker ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Address</th>
            <th>Age</th>
            <th>Gender</th>
            <th>Type of Seeker</th>
          </tr>
          <xsl:for-each select="Users/AssistanceSeeker">
            <tr>
              <td><xsl:value-of select="SeekerID"/></td>
              <td><xsl:value-of select="contactInfos/Name"/></td>
              <td><xsl:value-of select="contactInfos/Email"/></td>
              <td><xsl:value-of select="contactInfos/address"/></td>
              <td><xsl:value-of select="age"/></td>
              <td><xsl:value-of select="gender"/></td>
              <td>
                <xsl:choose>
                  <xsl:when test="typeOfSeeker/Elderly">Elderly</xsl:when>
                  <xsl:when test="typeOfSeeker/Handicap">Handicap</xsl:when>
                  <xsl:when test="typeOfSeeker/postpartum">Postpartum</xsl:when>
                </xsl:choose>
              </td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- Health Providers Table -->
        <h2>Health Providers</h2>
        <table>
          <tr>
            <th>Provider ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Address</th>
            <th>Type of Provider</th>
          </tr>
          <xsl:for-each select="Users/HealthProviders">
            <tr>
              <td><xsl:value-of select="ProviderID"/></td>
              <td><xsl:value-of select="providerInfos/Name"/></td>
              <td><xsl:value-of select="providerInfos/Email"/></td>
              <td><xsl:value-of select="providerInfos/address"/></td>
              <td>
                <xsl:choose>
                  <xsl:when test="TypeOfHealthProviders/ServiceCompanies">Service Company</xsl:when>
                  <xsl:when test="TypeOfHealthProviders/aloneProviders">Individual Provider</xsl:when>
                </xsl:choose>
              </td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- Services Table -->
        <h2>Services</h2>
        <table>
          <tr>
            <th>Service Type</th>
            <th>Service ID</th>
            <th>Provider ID</th>
            <th>Occurrence</th>
            <th>Description</th>
            <th>Scheduling</th>
          </tr>
          <xsl:for-each select="Services/*">
            <tr>
              <td><xsl:value-of select="name()"/></td>
              <td><xsl:value-of select="ServiceInfos/ServiceID"/></td>
              <td><xsl:value-of select="ServiceInfos/ProviderID"/></td>
              <td><xsl:value-of select="@occurrence"/></td>
              <td><xsl:value-of select="Description"/></td>
              <td><xsl:value-of select="SCHEDULING"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- Activities Table -->
        <h2>Activities</h2>
        <table>
          <tr>
            <th>Activity Type</th>
            <th>Activity ID</th>
            <th>Provider ID</th>
            <th>Occurrence</th>
            <th>Description</th>
            <th>Scheduling</th>
            <th>Duration</th>
          </tr>
          <xsl:for-each select="Activities/*">
            <tr>
              <td><xsl:value-of select="name()"/></td>
              <td><xsl:value-of select="ActivityInfo/ActivityID"/></td>
              <td><xsl:value-of select="ActivityInfo/ProviderID"/></td>
              <td><xsl:value-of select="@occurrence"/></td>
              <td><xsl:value-of select="Description"/></td>
              <td><xsl:value-of select="SCHEDULING"/></td>
              <td><xsl:value-of select="Duration"/></td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- User Participation Table -->
        <h2>User Participation</h2>
        <table>
          <tr>
            <th>Seeker ID</th>
            <th>Service Provider IDs</th>
            <th>Activity Provider ID</th>
            <th>Service IDs</th>
            <th>Activity ID</th>
            <th>Participation Dates (Services)</th>
            <th>Participation Date (Activities)</th>
          </tr>
          <xsl:for-each select="UserParticipation/entry">
            <tr>
              <td><xsl:value-of select="SeekerID"/></td>
              <td><xsl:value-of select="ServiceProviderID"/></td>
              <td><xsl:value-of select="ActivityProviderID"/></td>
              <td><xsl:value-of select="ServiceID"/></td>
              <td><xsl:value-of select="ActivityID"/></td>
              <td>
                <xsl:for-each select="ParticipationDateForServices">
                  <div>ServiceID: <xsl:value-of select="@ServiceID"/> Date: <xsl:value-of select="."/></div>
                </xsl:for-each>
              </td>
              <td><xsl:value-of select="ParticipationDateForActivities"/></td>
            </tr>
          </xsl:for-each>
        </table>

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
