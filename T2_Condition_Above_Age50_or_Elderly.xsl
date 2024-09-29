<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- Setting age threshold and defining the type of aassistance seeker to make the selection somehow dynamic -->
    <xsl:param name="ageThreshold" select="50"/>
    <xsl:param name="seekerType" select="'Elderly'"/>

    <xsl:output method="html" encoding="UTF-8"/>

    <!-- Defining the template of the report -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Assistance Seeker Report</title>
            </head>
            <body>
			<!-- Notice the part of the head title is dynamic base on the parameter defined above -->
                <h3>Assistance Seekers (Filtered by Age > <xsl:value-of select="$ageThreshold"/> or Type: <xsl:value-of select="$seekerType"/>)</h3>
                <table border="2" bgcolor="black">
                    <tr>
                        <th style="color: white;">Seeker Name</th>
                        <th style="color: white;">Seeker ID</th>
                        <th style="color: white;">Age</th>
                        <th style="color: white;">Type of Seeker</th>
						<th style="color: white;"> Gender</th>
                        <th style="color: white;">Comment</th>
                    </tr>

                    <!-- Assistance Seekers iteration and apply sort -->
                    <xsl:for-each select="/ManagementSystem/Users/AssistanceSeeker">
                        <xsl:sort select="age" data-type="number" order="descending"/>
                        
                        <!-- Filter dynamically using parameters for age and type -->
                        <xsl:if test="typeOfSeeker/*[name() = $seekerType] or number(age) &gt; $ageThreshold">
                            <tr>
                                <td style="color: white;"><xsl:value-of select="contactInfos/Name"/></td>
                                <td style="color: white;"><xsl:value-of select="SeekerID"/></td>
                                <td style="color: white;"><xsl:value-of select="age"/></td>
                                <td style="color: white;"><xsl:value-of select="name(typeOfSeeker/*)"/></td>
								<td style="color: white;"><xsl:value-of select="gender"/></td>	

                                <td style="color: white;">
                                    <!-- Conditional comment based Handicap status and age -->
                                    <xsl:choose>
                                        <!-- If the seeker is both  Handicap and age > 50 -->									
                                        <xsl:when test="typeOfSeeker/Handicap and number(age) &gt; $ageThreshold">
                                            <xsl:text>Needs special care</xsl:text>
                                        </xsl:when>
										<!-- Otherwise, provide another comment -->
                                        <xsl:otherwise>
                                            <xsl:text>See case by case for special care</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                            </tr>
                        </xsl:if>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
