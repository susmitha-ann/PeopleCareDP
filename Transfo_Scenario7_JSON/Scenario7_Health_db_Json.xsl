<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" encoding="UTF-8" indent="yes"/>
	<!-- Root template -->
	<xsl:template match="/">
        {
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
									
                                    "ServiceCompanies": {
										"companieID": "<xsl:value-of select='TypeOfHealthProviders/ServiceCompanies/companieID'/>",
										"CompanieInfos": {
											"Name": "<xsl:value-of select='TypeOfHealthProviders/ServiceCompanies/CompanieInfos/Name'/>",
											"Email": "<xsl:value-of select='TypeOfHealthProviders/ServiceCompanies/CompanieInfos/Email'/>",
											"address": "<xsl:value-of select='TypeOfHealthProviders/ServiceCompanies/CompanieInfos/address'/>"
										}
									}
                                </xsl:when>
				<xsl:when test="TypeOfHealthProviders/aloneProviders">
                                    "aloneProviders": {
                                        "PhoneNumber": "<xsl:value-of select='TypeOfHealthProviders/aloneProviders/PhoneNumber'/>",
                                        "gender": "<xsl:value-of select='TypeOfHealthProviders/aloneProviders/gender'/>"
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
