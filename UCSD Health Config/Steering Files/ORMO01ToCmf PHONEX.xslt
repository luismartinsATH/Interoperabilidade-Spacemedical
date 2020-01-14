<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">
  <xsl:include href="CommonTemplates.xslt"/>

  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <Message>
      <Processing>
        <Action type="InsertOrUpdate"/>
        <MessageType>ORM^O01</MessageType>
        <EventTime>
          <xsl:call-template name="FunctionHl7ToXmlDateOrNow">
            <xsl:with-param name ="date" select="/Hl7XmlMessage/EVN/EVN.2"/>
          </xsl:call-template>
        </EventTime>
      </Processing>
      <Patient>
        <PatientID>
<!-- Grab the Org from the MSH header as that is the Customer Orginization  -->
 
					<!-- Function calls for Organisation, PID, PID2, PID3 located in  CommonTemplates  -->
					<!--
       <PatientID>  
          <Organisation><xsl:call-template name="FunctionSelectOrganisation"/></Organisation>
          <PatientNumber><xsl:call-template name="FunctionSelectPatientId"/></PatientNumber>
          <PatientNumber2><xsl:call-template name="FunctionSelectPatientId2"/></PatientNumber2>
		  <PatientNumber3><xsl:call-template name="FunctionSelectPatientId3"/></PatientNumber3>
          <NationalId></NationalId>		  
        </PatientID>			
					-->
        <PatientID>
         <Organisation>
                  <xsl:value-of select="/Hl7XmlMessage/MSH/MSH.2"/>
          </Organisation>
	  
          <PatientNumber>
            <xsl:call-template name="FunctionSelectPatientId"/>
          </PatientNumber>
          <PatientNumber2>
            <xsl:value-of select="/Hl7XmlMessage/PID/PID.19"/>
          </PatientNumber2>
        </PatientID>		
		
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
		  <HomePhone><xsl:value-of select="/Hl7XmlMessage/PID/PID.13/PID.13.1"/></HomePhone>
          <WorkPhone><xsl:value-of select="/Hl7XmlMessage/PID/PID.13/PID.13.2"/></WorkPhone>
          <MobilePhone></MobilePhone>
          <Email><xsl:value-of select="/Hl7XmlMessage/PID/PID.13/PID.13.4"/></Email>  <!-- grab the email address in PID.13.4  lms 9-12-2017  -->
		  
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
          <PlacerNumber>    <!-- grab just the ORC.2.1 segment as that has the order # lms 9-12-2017  -->
             <xsl:value-of select="/Hl7XmlMessage/ORC/ORC.2/ORC.2.1"/>
          </PlacerNumber>
          <Procedure>
            <xsl:value-of select="/Hl7XmlMessage/OBR/OBR.4/OBR.4.1"/>^<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.4/OBR.4.2"/>^<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.4/OBR.4.3"/>
          </Procedure>
		<!--    **********  FROM LomondMessagingService codes   *****  LMS 2-26-2018
			 <SupportedType hl7Code="ABPMONITOR^Nephrology Ambulatory BP Monitoring^ABP" sentinelType="BP" />    or Ambulatoryy -->
		  
		  <TestType>
			<xsl:call-template name="FunctionHl7ToSentinelProcedure">
			<xsl:with-param name="procedure">
            <xsl:value-of select="/Hl7XmlMessage/OBR/OBR.4/OBR.4.1"/>^<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.4/OBR.4.2"/>
			</xsl:with-param>
			</xsl:call-template>
          </TestType>

          <RequestedDateTime>
            <xsl:call-template name="FunctionHl7ToXmlDateOrNow">
              <xsl:with-param name ="date" select="/Hl7XmlMessage/ORC/ORC.7/ORC.7.4"/>
            </xsl:call-template>
          </RequestedDateTime>
          <!-- Just grab exactly what is in the staff number, family name and given name components
        of the ordering provider as this will be the form it is returned in report messages. -->
          <OrderPlacer>
            <xsl:value-of select="/Hl7XmlMessage/OBR/OBR.16/OBR.16.1"/>^<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.16/OBR.16.2"/>^<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.16/OBR.16.3"/>^<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.16/OBR.16.4"/>^<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.16/OBR.16.5"/>^^^^^^^^<xsl:value-of select="/Hl7XmlMessage/OBR/OBR.16/OBR.16.13"/>
          </OrderPlacer>
          
			
			<!--  <xsl:value-of select="/Hl7XmlMessage/ZIS/ZIS.1"/> -->
		  <Notes>
			  <xsl:call-template name="FunctionSelectNTEFields"/>
          </Notes>

		  
        </Order>
      </Orders>
	  		<!-- Grab the Folder for the report to be placed in when the Report is Confirmed See CommonTemplates for Report Folder info. lms 10-10-2017 -->
		<Test>
			<UserDefinedField1Value><xsl:value-of select="/Hl7XmlMessage/PV1/PV1.11"/></UserDefinedField1Value>
		</Test>
    </Message>
  </xsl:template>

</xsl:stylesheet>