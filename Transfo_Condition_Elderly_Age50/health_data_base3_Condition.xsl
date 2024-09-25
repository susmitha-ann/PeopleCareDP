<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>MANAGEMENT SYSTEM MEASURES</title>
            </head>
            <body>
                <h3>Assistance Seeker (if Elderly or Age > 50))sorted by Age</h3>
                <TABLE border="2" BGCOLOR="black">
                    <TR>
                        <TH style="color: white; margin-left: 20px"> Assistance Seeker Name</TH>
                        <TH style="color: white; margin-left: 20px"> Assistance Seeker ID</TH>
                        <TH style="color: white; margin-left: 20px"> age</TH>
                        <TH style="color: white; margin-left: 20px"> type Of Seeker </TH>
                        <TH style="color: white; margin-left: 20px"> Comment </TH>
                    </TR>
                    <xsl:for-each select="/ManagementSystem/Users/AssistanceSeeker">
                        <!-- Sort by age in descending order -->
                        <xsl:sort select="age" data-type="number" order="descending"/>
                        
                        <!-- Check if typeOfSeeker contains Elderly or age is greater than 50 -->
                        <xsl:if test="typeOfSeeker/Elderly or number(age) &gt; 50">
                            <TR>
                                <TD style="color: white; margin-left: 20px">
                                    <!-- Assistance Seeker Name -->
                                    <xsl:value-of select="contactInfos/Name"/>
                                </TD>
                                <TD style="color: white; margin-left: 20px">
                                    <!-- Assistance Seeker ID -->
                                    <xsl:value-of select="SeekerID"/>
                                </TD>
                                <TD style="color: white; margin-left: 20px">
                                    <!-- Assistance Seeker Age -->
                                    <xsl:value-of select="age"/>
                                </TD>
                                <TD style="color: white; margin-left: 20px">
                                    <!-- Type Of Seeker -->
                                    <xsl:value-of select="name(typeOfSeeker/*)"/>
                                </TD>
                                <TD style="color: white; margin-left: 20px">
                                    <!-- Conditional comment based on Elderly and Handicap status -->
                                    <xsl:choose>
                                        <!-- If the seeker is both Elderly and Handicap and age > 50 -->
                                        <xsl:when test="typeOfSeeker/Handicap and number(age) &gt; 50">
                                            <xsl:text>Needs special care</xsl:text>
                                        </xsl:when>
                                        <!-- Otherwise, provide another comment -->
                                        <xsl:otherwise>
                                            <xsl:text>See case by case for special care</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </TD>
                            </TR>
                        </xsl:if>
                    </xsl:for-each>
                </TABLE>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
