<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- Output as XML -->
    <xsl:output method="xml" indent="yes"/>

    <!-- Template for the root element -->
    <xsl:template match="/">
        <AssistanceData>
            <!-- Loop through each Assistance Seeker -->
            <xsl:for-each select="/ManagementSystem/Users/AssistanceSeeker">
                <Seeker>
                    <!-- Extract Seeker Name and Age -->
                    <Name><xsl:value-of select="contactInfos/Name"/></Name>
                    <Age><xsl:value-of select="age"/></Age>
                    
                    <!-- Loop through each Health Provider associated with the Seeker -->
                    <xsl:for-each select="HealthProviders">
                        <Provider>
                            <Name><xsl:value-of select="providerInfos/Name"/></Name>
                            <!-- Extract the service type based on the provider's ID -->
                            <ServiceType>
                                <xsl:choose>
                                    <xsl:when test="../../Services/HomeCare/ServiceInfos/ProviderID = current()/ProviderID">Home Care</xsl:when>
                                    <xsl:when test="../../Services/MedicalCare/ServiceInfos/ProviderID = current()/ProviderID">Medical Care</xsl:when>
                                    <xsl:when test="../../Services/Postpartum-NeonatalCARE/ServiceInfos/ProviderID = current()/ProviderID">Postpartum-Neonatal Care</xsl:when>
                                    <xsl:when test="../../Services/HomeRehabilitation/ServiceInfos/ProviderID = current()/ProviderID">Home Rehabilitation</xsl:when>
                                    <xsl:otherwise>Other Services</xsl:otherwise>
                                </xsl:choose>
                            </ServiceType>
                        </Provider>
                    </xsl:for-each>
                </Seeker>
            </xsl:for-each>
        </AssistanceData>
    </xsl:template>
</xsl:stylesheet>
