<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" encoding="UTF-8" indent="yes"/>
	<!-- Root template -->
	<xsl:template match="/">
        {
            "$schema": "https://example.com/HealthDatabase.schema.json",
			"HealthProviders": [
                <xsl:for-each select="ManagementSystem/Users/AssistanceSeeker/HealthProviders">
                    {
                        "ProviderID": "<xsl:value-of select='ProviderID'/>",
                        "providerInfos": {
                            "Name": "<xsl:value-of select='providerInfos/Name'/>",
                            "Email": "<xsl:value-of select='providerInfos/Email'/>",
                            "address": "<xsl:value-of select='providerInfos/address'/>"
                        },
                        "TypeOfHealthProviders": {
                            <xsl:choose>
				<xsl:when test="TypeOfHealthProviders/ServiceCompanies">
					<xsl:variable name="Companies" select="TypeOfHealthProviders/ServiceCompanies"/>
									
                                    "ServiceCompanies": {
										"companieID": "<xsl:value-of select='$Companies/companieID'/>",
										"CompanieInfos": {
											"Name": "<xsl:value-of select='$Companies/CompanieInfos/Name'/>",
											"Email": "<xsl:value-of select='$Companies/CompanieInfos/Email'/>",
											"address": "<xsl:value-of select='$Companies/CompanieInfos/address'/>"
										}
									}
                                </xsl:when>
				<xsl:when test="TypeOfHealthProviders/aloneProviders">
					<xsl:variable name="independent" select="TypeOfHealthProviders/aloneProviders"/>
                                    "aloneProviders": {
                                        "PhoneNumber": "<xsl:value-of select='$independent/PhoneNumber'/>",
                                        "gender": "<xsl:value-of select='$independent/gender'/>"
                                    }
                                </xsl:when>
				<!-- Add more cases here if there are other types of providers -->
				<xsl:otherwise>
                                    "UnknownProvider": {}
                                </xsl:otherwise>
			</xsl:choose>
                        }
                    }
                    <xsl:if test="position() != last()">,</xsl:if>
		</xsl:for-each>
            ],
            "Services": [
                <xsl:for-each select="ManagementSystem/Users/AssistanceSeeker/Services/*">
                    {
                        "type": "<xsl:value-of select='name()'/>",
                        "occurrence": "<xsl:value-of select='@occurrence'/>",
                        "ServiceInfos": {
                            "ServiceID": "<xsl:value-of select='ServiceInfos/ServiceID'/>",
                            "ProviderID": "<xsl:value-of select='ServiceInfos/ProviderID'/>"
                        },
                        "Description": "<xsl:value-of select='Description'/>",
                        "SCHEDULING": "<xsl:value-of select='SCHEDULING'/>"
                    }
                    <xsl:if test="position() != last()">,</xsl:if>
		</xsl:for-each>
            ]
        }
    </xsl:template>
</xsl:stylesheet>
