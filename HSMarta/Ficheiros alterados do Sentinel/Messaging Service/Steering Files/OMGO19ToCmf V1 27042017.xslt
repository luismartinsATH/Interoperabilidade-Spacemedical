<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">
  <xsl:include href="CommonTemplates.xslt"/>

  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <Message>
      <Processing>
        <Action type="InsertOrUpdate"/>
        <MessageType>OMG^O19</MessageType>
        <EventTime>
          <xsl:call-template name="FunctionHl7ToXmlDateOrNow">
            <xsl:with-param name ="date" select="/Hl7XmlMessage/EVN/EVN.2"/>
          </xsl:call-template>
        </EventTime>
      </Processing>
      <Patient>
        <PatientID>
          <Organisation>
           <!--  <xsl:value-of select="/Hl7XmlMessage/PID/PID.3/PID.3.4"/> --> <!-- LMM 27042017 disbale temporário da organização -->
          </Organisation>
          <PatientNumber>
            <xsl:call-template name="FunctionSelectPatientId"/>
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
        <Height>
          <xsl:call-template name="ExtractPatientHeight"/>
        </Height>
        <Weight>
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
          <Attending>
            <StaffNumber>
              <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.7/PV1.7.1"/>
            </StaffNumber>
            <Title>
              <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.7/PV1.7.6"/>
            </Title>
            <GivenName>
              <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.7/PV1.7.3"/>
            </GivenName>
            <FamilyName>
              <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.7/PV1.7.2"/>
            </FamilyName>
          </Attending>
          <Referring>
            <StaffNumber>
              <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.8/PV1.8.1"/>
            </StaffNumber>
            <Title>
              <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.8/PV1.8.6"/>
            </Title>
            <GivenName>
              <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.8/PV1.8.3"/>
            </GivenName>
            <FamilyName>
              <xsl:value-of select="/Hl7XmlMessage/PV1/PV1.8/PV1.8.2"/>
            </FamilyName>
          </Referring>
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
      <Orders>
        <Order>
          <ControlCode>
            <xsl:value-of select="/Hl7XmlMessage/ORC/ORC.1"/>
          </ControlCode>
          <PlacerNumber>
 <!--            <xsl:value-of select="/Hl7XmlMessage/ORC/ORC.2/ORC.2.1"/>^<xsl:value-of select="/Hl7XmlMessage/ORC/ORC.2/ORC.2.2"/> --> <!-- LMM Alteração de placer Number -->
            <xsl:value-of select="/Hl7XmlMessage/ORC/ORC.2"/>			
          </PlacerNumber>
          <Procedure>
<!--             <xsl:value-of select="/Hl7XmlMessage/OBR/OBR.4/OBR.4.1"/>^<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.4/OBR.4.2"/> --> <!-- LMM 27042017 Alteração do código do exame -->
			<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.4"/>
          </Procedure>
         <TestType>
         <!--    <xsl:value-of select="/Hl7XmlMessage/OBR/OBR.4/OBR.4.1"/>^<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.4/OBR.4.2"/> --> <!-- LMM 27042017 Alteração do código do exame -->
			<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.4"/>
          </TestType>
          <RequestedDateTime>
            <xsl:call-template name="FunctionHl7ToXmlDateOrNow">
              <xsl:with-param name ="date" select="/Hl7XmlMessage/ORC/ORC.7/ORC.7.4"/>
            </xsl:call-template>
          </RequestedDateTime>
          <!-- Just grab exactly what is in the staff number, family name and given name components
        of the ordering provider as this will be the form it is returned in report messages. -->
          <OrderPlacer>
            <xsl:value-of select="/Hl7XmlMessage/OBR/OBR.16/OBR.16.1"/>^<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.16/OBR.16.2"/>^<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.16/OBR.16.3"/>
          </OrderPlacer>
          <Notes>
            <xsl:value-of select="/Hl7XmlMessage/ZIS/ZIS.1"/>
          </Notes>
        </Order>
      </Orders>
    </Message>
  </xsl:template>

</xsl:stylesheet>