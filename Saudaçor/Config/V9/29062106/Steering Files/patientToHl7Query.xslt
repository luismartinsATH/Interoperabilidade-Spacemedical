<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:utils="urn:CodeUtils">
  <!-- PARAMS: -->
  <!-- Control ID (unique numeric ID for an HL7 message) -->
  <xsl:param name="MessageID"/>
  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>
  
  <xsl:template match="/">
  <Hl7XmlMessage>
    <MSH>
      <MSH.1>|^~\&amp;</MSH.1>
      <MSH.2>Sentinel</MSH.2>
      <MSH.3>Cardiology</MSH.3>
      <MSH.4>TestPartner</MSH.4>
      <MSH.5>TestFacility</MSH.5>
      <MSH.6><xsl:value-of select="$now"/></MSH.6>
      <MSH.8>
        <MSH.8.1>QRY</MSH.8.1>
        <MSH.8.2>A19</MSH.8.2>
      </MSH.8>
      <MSH.9><xsl:value-of select="$MessageID"/></MSH.9>
      <MSH.10>P</MSH.10>
      <MSH.11>2.5</MSH.11>
    </MSH>
    <QRD>
      <QRD.1><xsl:value-of select="$now"/></QRD.1>
      <QRD.2>R</QRD.2>
      <QRD.3>I</QRD.3>
      <QRD.4><xsl:value-of select="$MessageID"/></QRD.4>
      <QRD.7>
        <QRD.7.1>100</QRD.7.1>
        <QRD.7.2>LI</QRD.7.2>
      </QRD.7>
      <QRD.8><xsl:value-of select="/Patient/PatientNumber"/></QRD.8>
      <QRD.9>DEM</QRD.9>
      <QRD.10>ALL</QRD.10>
    </QRD>
  </Hl7XmlMessage>
</xsl:template>
</xsl:stylesheet>