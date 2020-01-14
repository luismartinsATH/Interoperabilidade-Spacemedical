<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">
  <xsl:include href="CommonTemplates.xslt"/>

  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <Message>
      <Processing>
        <Action type="Merge"/>
        <MessageType>ADT^A40</MessageType>
        <EventTime>
          <xsl:call-template name="FunctionHl7ToXmlDateOrNow">
            <xsl:with-param name ="date" select="/Hl7XmlMessage/EVN/EVN.2"/>
          </xsl:call-template>
        </EventTime>
      </Processing>
      <Patient>
        <PatientID>
          <Organisation><xsl:value-of select="/Hl7XmlMessage/MSH/MSH.3"/><!-- <xsl:value-of select="/Hl7XmlMessage/PID/PID.3/PID.3.4"/> --></Organisation>
          <PatientNumber><xsl:call-template name="FunctionSelectPatientId"/></PatientNumber>
          <PatientNumber2><xsl:value-of select="/Hl7XmlMessage/PID/PID.18/PID.18.1"/><!-- <xsl:value-of select="/Hl7XmlMessage/PID/PID.19"/> --></PatientNumber2>
          <PatientNumber3></PatientNumber3>
          <NationalId></NationalId>
          <SourcePatients><xsl:call-template name="GetPatientsToMerge"/></SourcePatients>
        </PatientID>
        <GivenName><xsl:value-of select="/Hl7XmlMessage/PID/PID.5/PID.5.2"/></GivenName>
        <FamilyName><xsl:value-of select="/Hl7XmlMessage/PID/PID.5/PID.5.1"/></FamilyName>
        <MaidenName><xsl:value-of select="/Hl7XmlMessage/ZPI/ZPI.4/ZPI.4.1"/></MaidenName>
        <MiddleInitials><xsl:value-of select="/Hl7XmlMessage/PID/PID.5/PID.5.3"/></MiddleInitials>
        <Title><xsl:value-of select="/Hl7XmlMessage/PID/PID.5/PID.5.5"/></Title>
        <DateOfBirth>
          <xsl:call-template name="FunctionHl7ToXmlDate">
            <xsl:with-param name="date" select="/Hl7XmlMessage/PID/PID.7"/>
          </xsl:call-template>
        </DateOfBirth>
        <Gender>
          <xsl:call-template name="FunctionHl7ToSentinelGender">
            <xsl:with-param name="gender" select="/Hl7XmlMessage/PID/PID.8"/>
          </xsl:call-template>
        </Gender>
        <Ethnicity><xsl:value-of select="/Hl7XmlMessage/PID/PID.10"/></Ethnicity>
        <Height><xsl:call-template name="ExtractPatientHeight"/></Height>
        <Weight><xsl:call-template name ="ExtractPatientWeight"/></Weight>
        <Deceased></Deceased>
        <InsuranceNumber></InsuranceNumber>
        <Address>
          <AddressLine1><xsl:value-of select="/Hl7XmlMessage/PID/PID.11/PID.11.1"/></AddressLine1>
          <AddressLine2><xsl:value-of select="/Hl7XmlMessage/PID/PID.11/PID.11.2"/></AddressLine2>
          <City><xsl:value-of select="/Hl7XmlMessage/PID/PID.11/PID.11.3"/></City>
          <CountyRegion><xsl:value-of select="/Hl7XmlMessage/PID/PID.11/PID.11.4"/></CountyRegion>
          <PostZipcode><xsl:value-of select="/Hl7XmlMessage/PID/PID.11/PID.11.5"/></PostZipcode>
          <Country><xsl:value-of select="/Hl7XmlMessage/PID/PID.11/PID.11.6"/></Country>
          <HomePhone><xsl:value-of select="/Hl7XmlMessage/PID/PID.13"/></HomePhone>
          <WorkPhone></WorkPhone>
          <MobilePhone></MobilePhone>
          <Email></Email>
        </Address>
        <ContactFamilyName></ContactFamilyName>
        <ContactGivenName></ContactGivenName>
        <ContactHomePhone></ContactHomePhone>
        <ContactMobilePhone></ContactMobilePhone>
        <ContactRelationship></ContactRelationship>
        <UserDefinedField1Value></UserDefinedField1Value>
        <UserDefinedField2Value></UserDefinedField2Value>
        <UserDefinedField3Value></UserDefinedField3Value>
        <UserDefinedField4Value></UserDefinedField4Value>
        <Admitted></Admitted>
        <Discharged></Discharged>
        <Visit>
          <Class><xsl:value-of select="/Hl7XmlMessage/PV1/PV1.2"/></Class>
          <CaseType>
            <xsl:call-template name="FunctionHl7toSentinelClass">
              <xsl:with-param name="class" select="/Hl7XmlMessage/PV1/PV1.2"/>
            </xsl:call-template>
          </CaseType>
          <VisitNumber><xsl:value-of select="/Hl7XmlMessage/PV1/PV1.19"/></VisitNumber>
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