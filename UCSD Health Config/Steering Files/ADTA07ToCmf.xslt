<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">
  <xsl:include href="CommonTemplates.xslt"/>

  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <Message>
      <Processing>
        <Action type="Update"/>
        <MessageType>ADT^A07</MessageType>
        <EventTime>
          <xsl:call-template name="FunctionHl7ToXmlDateOrNow">
            <xsl:with-param name ="date" select="/Hl7XmlMessage/EVN/EVN.2"/>
          </xsl:call-template>
        </EventTime>
      </Processing>
      <Patient>
        <PatientID>  <!-- Function calls for Organisation, PID, PID2, PID3 located in  CommonTemplates  -->
          <Organisation><xsl:call-template name="FunctionSelectOrganisation"/></Organisation>
          <PatientNumber><xsl:call-template name="FunctionSelectPatientId"/></PatientNumber>
          <PatientNumber2><xsl:call-template name="FunctionSelectPatientId2"/></PatientNumber2>
		  <PatientNumber3><xsl:call-template name="FunctionSelectPatientId3"/></PatientNumber3>
          <NationalId></NationalId>		  
        </PatientID>
        <Visit>
          <Class><xsl:value-of select="/Hl7XmlMessage/PV1/PV1.2"/></Class>
          <CaseType>
            <xsl:call-template name="FunctionHl7toSentinelClass">
              <xsl:with-param name="class" select="/Hl7XmlMessage/PV1/PV1.2"/>
            </xsl:call-template>
          </CaseType>
          <VisitNumber><xsl:value-of select="/Hl7XmlMessage/PV1/PV1.19"/></VisitNumber>
        </Visit>
        <Location>
          <PointOfCare><xsl:value-of select="/Hl7XmlMessage/PV1/PV1.3/PV1.3.1"/></PointOfCare>
          <Ward><xsl:value-of select="/Hl7XmlMessage/PV1/PV1.3/PV1.3.2"/></Ward>
          <Bed><xsl:value-of select="/Hl7XmlMessage/PV1/PV1.3/PV1.3.3"/></Bed>
          <Facility><xsl:value-of select="/Hl7XmlMessage/PV1/PV1.3/PV1.3.4"/></Facility>
        </Location>
      </Patient>
    </Message>
  </xsl:template>

</xsl:stylesheet>