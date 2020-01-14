<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">
  <xsl:include href="CommonTemplates.xslt"/>

  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <Message>
      <Processing>
        <Action type="ConditionalUpdate"/>
        <MessageType>ADT^A08</MessageType>
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
        <GivenName>
          <xsl:value-of select="/Hl7XmlMessage/PID/PID.5/PID.5.2"/>
        </GivenName>
        <FamilyName>
          <xsl:value-of select="/Hl7XmlMessage/PID/PID.5/PID.5.1"/>
        </FamilyName>
        <MaidenName>
          <xsl:value-of select="/Hl7XmlMessage/ZPI/ZPI.4/ZPI.4.1"/>
        </MaidenName>
        <MiddleInitials>
          <xsl:value-of select="/Hl7XmlMessage/PID/PID.5/PID.5.3"/>
        </MiddleInitials>
        <Title>
          <xsl:value-of select="/Hl7XmlMessage/PID/PID.5/PID.5.5"/>
        </Title>
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
        <Ethnicity>
          <xsl:value-of select="/Hl7XmlMessage/PID/PID.10"/>
        </Ethnicity>
        <Height unit="M">
          <xsl:call-template name="ExtractPatientHeight"/>
        </Height>
        <Weight unit="KG">
          <xsl:call-template name ="ExtractPatientWeight"/>
        </Weight>
        <Address>
          <AddressLine1>
            <xsl:value-of select="/Hl7XmlMessage/PID/PID.11/PID.11.1"/>
          </AddressLine1>
          <AddressLine2>
            <xsl:value-of select="/Hl7XmlMessage/PID/PID.11/PID.11.2"/>
          </AddressLine2>
          <City>
            <xsl:value-of select="/Hl7XmlMessage/PID/PID.11/PID.11.3"/>
          </City>
          <CountyRegion>
            <xsl:value-of select="/Hl7XmlMessage/PID/PID.11/PID.11.4"/>
          </CountyRegion>
          <PostZipcode>
            <xsl:value-of select="/Hl7XmlMessage/PID/PID.11/PID.11.5"/>
          </PostZipcode>
          <Country>
            <xsl:value-of select="/Hl7XmlMessage/PID/PID.11/PID.11.6"/>
          </Country>
          <HomePhone>
            <xsl:value-of select="/Hl7XmlMessage/PID/PID.13"/>
          </HomePhone>
        </Address>
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
        </Visit>
        <Location>
          <PointOfCare>
            <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.3/PV1.3.1"/>
          </PointOfCare>
          <Ward>
            <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.3/PV1.3.2"/>
          </Ward>
          <Bed>
            <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.3/PV1.3.3"/>
          </Bed>
          <Facility>
            <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.3/PV1.3.4"/>
          </Facility>
        </Location>
      </Patient>
    </Message>
  </xsl:template>

</xsl:stylesheet>