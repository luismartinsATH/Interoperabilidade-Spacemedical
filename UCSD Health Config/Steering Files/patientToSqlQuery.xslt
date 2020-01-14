<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:utils="urn:CodeUtils">
  <!-- PARAMS: -->
  <!-- Control ID (unique numeric ID for an HL7 message) -->
  <xsl:param name="MessageID"/>
  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <SqlQueryMessage>
      <QueryID>
        <xsl:value-of select="$MessageID"/>
      </QueryID>
      <PatientID>
        <xsl:value-of select="/Patient/PatientNumber"/>
      </PatientID>
    </SqlQueryMessage>
  </xsl:template>
</xsl:stylesheet>