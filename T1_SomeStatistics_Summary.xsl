<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="UTF-8"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Assistance Seeker Statistics</title>
				<!-- Style tag define style for multi-elements. in this case it will apply to h1,h2 and h3-->
				<!-- {font-family: sans-serif, color: blue} : This apply a font sans-serif on h1,h2, h3.-->
				<!--ul {font-size: 14pt}: this applies a size font of 14 on each element in the list).-->
				<style type="text/css"> h2, h3 {font-family: sans-serif, color: blue} ul {font-size: 14pt}
					ul {list-style-type: none; /* Remove default bullets */}
					li {
						position: relative;
						padding-left: 20px; /* Space for the star */
						}
						li:before {
						content: "*"; /* Star bullet */
						position: absolute;
						left: 0; /* Position star to the left */
						color: blue; /* Optional: change color of the star */
						}

				</style>
			</head>
			<body>
				<!--style="color: blue; margin-left: 20px" : Define the color of the heading to bleu -->
				<!-- margin-left: 20px" : This adds a heading magin of 20-pixel space to the left -->
				<h1 style="color: blue; margin-left: 10px">Assistance Seeker Statistics</h1>
				<!-- Total age and count for all assistance seekers -->
				<xsl:variable name="totalAge" select="sum(/ManagementSystem/Users/AssistanceSeeker/age)"/>
				<xsl:variable name="totalCount" select="count(/ManagementSystem/Users/AssistanceSeeker)"/>
				<!-- Average age for all assistance seekers -->
				<h3> Age Info - Assistance Seekers</h3>
				<ul>
					<!-- stand for unordered list and create bullet point for each element in the list-->
					<li>Average Age :<xsl:value-of select="$totalAge div $totalCount"/>
					</li>
					<!-- Minimum Age for all Assistance Seekers -->
					<!--<h3>Minimum Age of Assistance Seekers</h3>-->
					<li> Minimum Age :
						<xsl:variable name="minAge">
							<xsl:for-each select="/ManagementSystem/Users/AssistanceSeeker">
								<xsl:sort select="age" data-type="number" order="ascending"/>
								<xsl:if test="position() = 1">
									<xsl:value-of select="age"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:variable>
						<xsl:value-of select="$minAge"/>
					</li>
					<!-- Maximum Age for all Assistance Seekers -->
					<!--<h3>Maximum Age of Assistance Seekers</h3>-->
					<li>Maximum Age :
						<xsl:variable name="maxAge">
							<xsl:for-each select="/ManagementSystem/Users/AssistanceSeeker">
								<xsl:sort select="age" data-type="number" order="descending"/>
								<xsl:if test="position() = 1">
									<xsl:value-of select="age"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:variable>
						<xsl:value-of select="$maxAge"/>
					</li>
				</ul>
				<!-- Average age by type of seeker -->
				<h3> Age info -Elder seeker </h3>
				<!-- The following calculate the Average Age of Elderly seekers -->
				<ul>
					<li>Elderly - Average age :
						<xsl:variable name="elderlyTotalAge" select="sum(/ManagementSystem/Users/AssistanceSeeker[typeOfSeeker/Elderly]/age)"/>
						<xsl:variable name="elderlyCount" select="count(/ManagementSystem/Users/AssistanceSeeker[typeOfSeeker/Elderly])"/>
						<xsl:value-of select="$elderlyTotalAge div $elderlyCount"/>
					</li>
					<!-- Minimum Age by Elder Seeker -->
					<!--<h3>Minimum Age</h3>-->
					<li>Elderly - Min age: 
							<xsl:variable name="minElderAge">
							<xsl:for-each select="/ManagementSystem/Users/AssistanceSeeker[typeOfSeeker/Elderly]">
								<xsl:sort select="age" data-type="number" order="ascending"/>
								<xsl:if test="position() = 1">
									<xsl:value-of select="age"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:variable>
						<xsl:value-of select="$minElderAge"/>
					</li>
					<!--<h3> Extracting the Maximum Age </h3>-->
					<li>Elderly - Max age: 
					<xsl:variable name="maxElderAge">
							<xsl:for-each select="/ManagementSystem/Users/AssistanceSeeker[typeOfSeeker/Elderly]">
								<xsl:sort select="age" data-type="number" order="descending"/>
								<xsl:if test="position() = 1">
									<xsl:value-of select="age"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:variable>
						<xsl:value-of select="$maxElderAge"/>
					</li>
				</ul>
				<h3> Age info -Handicap seeker </h3>
				<!-- The following calculate the Average Age of Handicap seekers -->
				<ul>
					<li> Handicap - Average age :
						<xsl:variable name="handicapTotalAge" select="sum(/ManagementSystem/Users/AssistanceSeeker[typeOfSeeker/Handicap]/age)"/>
						<xsl:variable name="handicapCount" select="count(/ManagementSystem/Users/AssistanceSeeker[typeOfSeeker/Handicap])"/>
						<xsl:value-of select="$handicapTotalAge div $handicapCount"/>
					</li>
					<li>Handicap - Min age: 
        <xsl:variable name="minHandicapAge">
							<xsl:for-each select="/ManagementSystem/Users/AssistanceSeeker[typeOfSeeker/Handicap]">
								<xsl:sort select="age" data-type="number" order="ascending"/>
								<xsl:if test="position() = 1">
									<xsl:value-of select="age"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:variable>
						<xsl:value-of select="$minHandicapAge"/>
					</li>
					<li>Handicap - Max Age: 
        <xsl:variable name="maxHandicapAge">
							<xsl:for-each select="/ManagementSystem/Users/AssistanceSeeker[typeOfSeeker/Handicap]">
								<xsl:sort select="age" data-type="number" order="descending"/>
								<xsl:if test="position() = 1">
									<xsl:value-of select="age"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:variable>
						<xsl:value-of select="$maxHandicapAge"/>
					</li>
				</ul>
				<!-- Percentage of assistance seekers by gender -->
				<h3>Percentage of Assistance Seekers by Gender</h3>
				<ul>
					<li> Male :
						<xsl:variable name="maleCount" select="count(/ManagementSystem/Users/AssistanceSeeker[gender='Male'])"/>
						<xsl:value-of select="($maleCount div $totalCount) * 100"/>%
					</li>
					<li> Female :
						<xsl:variable name="femaleCount" select="count(/ManagementSystem/Users/AssistanceSeeker[gender='Female'])"/>
						<xsl:value-of select="($femaleCount div $totalCount) * 100"/>%
					</li>
				</ul>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>