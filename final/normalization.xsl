<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Root template match -->
	<xsl:template match="/">
		<ManagementSystem>
			<xsl:apply-templates select="ManagementSystem/Users/AssistanceSeeker"/>
			<xsl:apply-templates select="ManagementSystem/Users/HealthProviders"/>
		</ManagementSystem>
	</xsl:template>
	<!-- Assistance Seeker -->
	<xsl:template match="AssistanceSeeker">
		<AssistanceSeeker>
			<SeekerID>
				<xsl:value-of select="SeekerID"/>
			</SeekerID>
			<contactInfos>
				<Name>
					<xsl:value-of select="contactInfos/Name"/>
				</Name>
				<Email>
					<xsl:value-of select="contactInfos/Email"/>
				</Email>
				<!-- Split the address into components -->
				<address>
					<street>
						<xsl:value-of select="substring-before(contactInfos/address, ',')"/>
					</street>
					<city>
						<xsl:value-of select="substring-before(substring-after(contactInfos/address, ','), ',')"/>
					</city>
					<state>
						<xsl:value-of select="substring-before(substring-after(substring-after(contactInfos/address, ', '), ','), ',')"/>
					</state>
					<zipcode>
						<xsl:value-of select="substring-after(substring-after(substring-after(contactInfos/address, ', '), ','), ',')"/>
					</zipcode>
				</address>
			</contactInfos>
			<age ageUnit="{@ageUnit}">
				<xsl:value-of select="age"/>
			</age>
			<gender>
				<xsl:value-of select="gender"/>
			</gender>
			<typeOfSeeker>
				<xsl:apply-templates select="typeOfSeeker/*"/>
			</typeOfSeeker>
		</AssistanceSeeker>
	</xsl:template>
	<!-- Health Providers -->
	<xsl:template match="HealthProviders">
		<HealthProviders>
			<ProviderID>
				<xsl:value-of select="ProviderID"/>
			</ProviderID>
			<providerInfos>
				<Name>
					<xsl:value-of select="providerInfos/Name"/>
				</Name>
				<Email>
					<xsl:value-of select="providerInfos/Email"/>
				</Email>
				<!-- Split the address into components -->
				<address>
					<street>
						<xsl:value-of select="substring-before(providerInfos/address, ',')"/>
					</street>
					<city>
						<xsl:value-of select="substring-before(substring-after(providerInfos/address, ','), ',')"/>
					</city>
					<state>
						<xsl:value-of select="substring-before(substring-after(substring-after(providerInfos/address, ', '), ','), ',')"/>
					</state>
					<zipcode>
						<xsl:value-of select="substring-after(substring-after(substring-after(providerInfos/address, ', '), ','), ',')"/>
					</zipcode>
				</address>
			</providerInfos>
		</HealthProviders>
	</xsl:template>
</xsl:stylesheet>