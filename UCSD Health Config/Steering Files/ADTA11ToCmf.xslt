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
        <PatientID>  <!-- Function calls for Organisation, PID, PID2, PID3 located in  CommonTemplates  -->
          <Organisation><xsl:call-template name="FunctionSelectOrganisation"/></Organisation>
          <PatientNumber><xsl:call-template name="FunctionSelectPatientId"/></PatientNumber>
          <PatientNumber2><xsl:call-template name="FunctionSelectPatientId2"/></PatientNumber2>
		  <PatientNumber3><xsl:call-template name="FunctionSelectPatientId3"/></PatientNumber3>
          <NationalId></NationalId>		  
        </PatientID>
        <Admitted>""</Admitted>
        <Discharged/>
        <Visit>
          <Class>
            <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.2"/>
          </Class>
          <CaseType>
            <xsl:call-template name="FunctionHl7toSentinelClass">
              <xsl:with-param name="class" select="/Hl7XmlMessage/PV1/PV1.2"/>
            </xsl:call-template>
          </CaseType>
          <VisitNumber>
            <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.19"/>
          </VisitNumber>
          <DateOpened>
            <xsl:call-template name="FunctionHl7ToXmlDateOrNow">
              <xsl:with-param name ="date" select="/Hl7XmlMessage/EVN/EVN.2"/>
            </xsl:call-template>
          </DateOpened>
          <DateClosed></DateClosed>
          <Attending>
            <StaffNumber></StaffNumber>
            <Title></Title>
            <GivenName></GivenName>
            <FamilyName></FamilyName>
          </Attending>
          <Referring>
            <StaffNumber></StaffNumber>
            <Title></Title>
            <GivenName></GivenName>
            <FamilyName></FamilyName>
          </Referring>
        </Visit>
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