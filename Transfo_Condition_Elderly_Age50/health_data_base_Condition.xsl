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
					</TR>
					<xsl:for-each select="/ManagementSystem/Users/AssistanceSeeker">
						<!-- Check if typeOfSeeker contains Elderly -->
						<xsl:sort select="age" data-type="number" order="descending"/>
						<xsl:if test="typeOfSeeker/Elderly or number(age) &gt; 50">
							<TR>
								<TD style="color: white; margin-left: 20px">
									<!-- selecting Assistance Seeker Name -->
									<xsl:value-of select="contactInfos/Name"/>
								</TD>
								<TD style="color: white; margin-left: 20px">
									<!-- selecting Assistance Seeker ID -->
									<xsl:value-of select="SeekerID"/>
								</TD>
								<TD style="color: white; margin-left: 20px">
									<!-- Assistance Seeker Age -->
									<xsl:value-of select="age"/>
								</TD>
								<TD style="color: white; margin-left: 20px">
									<!-- seaching for the type of seeker -->
									<xsl:value-of select="name(typeOfSeeker/*)"/>
								</TD>
							</TR>
						</xsl:if>
					</xsl:for-each>
				</TABLE>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>