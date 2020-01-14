<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <xsl:param name="MessageID"/>
  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <Hl7XmlMessage>
      <MSH>
        <MSH.1>|^~\&amp;</MSH.1>
        <MSH.2>Sentinel</MSH.2>
        <MSH.3>CHLC</MSH.3>
        <MSH.4>CIAR</MSH.4>
        <MSH.5>CHLC</MSH.5>
<!--         <MSH.3>Cardiology</MSH.3>
        <MSH.4>TestPartner</MSH.4>
        <MSH.5>TestFacility</MSH.5> -->		
        <MSH.6>
          <xsl:value-of select="$now"/>
        </MSH.6>
        <MSH.7 />
        <MSH.8>
          <MSH.8.1>
            <xsl:call-template name="GetMessageType"/>
          </MSH.8.1>
          <MSH.8.2>
            <xsl:call-template name="GetTriggerEvent"/>
          </MSH.8.2>
          <MSH.8.3>
            <xsl:call-template name="GetMessageType"/>
          </MSH.8.3>
        </MSH.8>
        <MSH.9>
          <xsl:value-of select="$MessageID"/>
        </MSH.9>
        <MSH.10>P</MSH.10>
        <MSH.11>2.3.1</MSH.11>
        <MSH.12 />
        <MSH.13 />
		<MSH.14>
			<xsl:value-of select="/Hl7XmlMessage/MSH/MSH.14"/>
		</MSH.14> <!-- LMM 27042017 Adicionado o MSH14 -->
      </MSH>
      <MSA>
        <MSA.1>AA</MSA.1>
        <MSA.2>
          <xsl:value-of select="/Hl7XmlMessage/MSH/MSH.9"/>
        </MSA.2>
        <MSA.3 />
      </MSA>
    </Hl7XmlMessage>
  </xsl:template>

  <xsl:template name="GetMessageType">
    <xsl:variable name="orderType" select="/Hl7XmlMessage/MSH/MSH.8/MSH.8.1"/>
    <xsl:choose>
      <xsl:when test="$orderType='ORM'">ORR</xsl:when>
      <xsl:otherwise>ORG</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="GetTriggerEvent">
    <xsl:variable name="orderType" select="/Hl7XmlMessage/MSH/MSH.8/MSH.8.1"/>
    <xsl:choose>
      <xsl:when test="$orderType='ORM'">O02</xsl:when>
      <xsl:otherwise>O20</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
</xsl:stylesheet>
