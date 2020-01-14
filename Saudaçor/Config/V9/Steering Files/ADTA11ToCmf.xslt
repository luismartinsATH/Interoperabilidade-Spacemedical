<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">
  <xsl:include href="CommonTemplates.xslt"/>

  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <Message>
      <Processing>
        <Action type="Update"/>
        <MessageType>ADT^A11</MessageType>
        <EventTime>
          <xsl:call-template name="FunctionHl7ToXmlDateOrNow">
            <xsl:with-param name ="date" select="/Hl7XmlMessage/EVN/EVN.2"/>
          </xsl:call-template>
        </EventTime>
      </Processing>
      <Patient>
        <PatientID>
          <PatientNumber>
            <xsl:value-of select="/Hl7XmlMessage/PID/PID.3"/>
          </PatientNumber>
          <PatientNumber2>
            <xsl:value-of select="/Hl7XmlMessage/PID/PID.19"/>
          </PatientNumber2>
        </PatientID>
        <Admitted>""</Admitted>
        <Discharged/>
        <!-- The following will clear the inpatient location because, in the absence
        of visit data, such as visit type, inpatient is assumed. -->
        <Location>
          <PointOfCare>""</PointOfCare>
          <Ward>""</Ward>
          <Bed>""</Bed>
          <Facility>""</Facility>
        </Location>
      </Patient>
    </Message>
  </xsl:template>

</xsl:stylesheet>