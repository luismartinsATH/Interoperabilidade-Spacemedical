<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">
  <xsl:include href="CommonTemplates.xslt"/>

  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <Message>
      <Processing>
        <Action type="UploadReport"/>
      </Processing>
      <Patient>
        <PatientID>
          <PatientNumber>
            <xsl:value-of select="/Q-Stress_Final_Report/Summary/EvIDPatientMRN"/>
          </PatientNumber>
          <PatientNumber2>
            <xsl:value-of select="/Q-Stress_Final_Report/Summary/EvIDPatientSSN"/>
          </PatientNumber2>
        </PatientID>
        <GivenName>
          <xsl:value-of select="substring-after(/Q-Stress_Final_Report/Summary/EvIDPatientFullName, ',')"/>
        </GivenName>
        <FamilyName>
          <xsl:value-of select="substring-before(/Q-Stress_Final_Report/Summary/EvIDPatientFullName, ',')"/>
        </FamilyName>
        <MaidenName></MaidenName>
        <MiddleInitials></MiddleInitials>
        <DateOfBirth>
          <xsl:call-template name="QuintonDobToXml">
            <xsl:with-param name="dob" select="/Q-Stress_Final_Report/Summary/EvIDPatientBirthdate"/>
          </xsl:call-template>
        </DateOfBirth>
        <Gender></Gender>
        <Height></Height>
        <Weight></Weight>
        <Address>
          <AddressLine1></AddressLine1>
          <AddressLine2></AddressLine2>
          <City></City>
          <CountyRegion></CountyRegion>
          <PostZipcode></PostZipcode>
          <Country></Country>
          <HomePhone></HomePhone>
        </Address>
        <Admitted></Admitted>
        <Discharged/>
        <Visit>
          <Class></Class>
          <VisitNumber></VisitNumber>
          <DateOpened></DateOpened>
        </Visit>
        <Location>
          <PointOfCare></PointOfCare>
          <Ward></Ward>
          <Bed></Bed>
          <Facility></Facility>
        </Location>
      </Patient>
      <Test>
        <StartDateTime></StartDateTime>
        <RecordingDuration></RecordingDuration>
        <RecorderModel>Quinton Q-Stress</RecorderModel>
        <RecorderSerialNumber></RecorderSerialNumber>
        <TestStatus></TestStatus>
        <Height></Height>
        <Weight></Weight>
        <TestCreatedDateTime></TestCreatedDateTime>
        <Priority></Priority>
        <DownloadFacility></DownloadFacility>
        <UserDefinedField1Value></UserDefinedField1Value>
        <UserDefinedField2Value></UserDefinedField2Value>
        <UserDefinedField3Value></UserDefinedField3Value>
        <UserDefinedField4Value></UserDefinedField4Value>
      </Test>
      <Reports>
        <Report>
          <TestType>stress</TestType>
          <RecordingDuration></RecordingDuration>
          <RecordingDateTime></RecordingDateTime>
          <ReportFormat></ReportFormat>
          <ReportType></ReportType>
          <Status>Unconfirmed</Status>
        </Report>
      </Reports>
    </Message>
  </xsl:template>

  <!-- This template converts the DOB in incoming XML documents from
  dd/mm/yyyy to yyyy-mm-dd -->
  <xsl:template name="QuintonDobToXml">
    <xsl:param name="dob"/>
    <xsl:call-template name="SelectToken">
      <xsl:with-param name="text" select="$dob"/>
      <xsl:with-param name="delimiter" select="string('/')"/>
      <xsl:with-param name="requiredIndex" select="2"/>
      <xsl:with-param name="currentIndex" select="0"/>
    </xsl:call-template>-<xsl:call-template name="SelectToken">
    <xsl:with-param name="text" select="$dob"/>
    <xsl:with-param name="delimiter" select="string('/')"/>
    <xsl:with-param name="requiredIndex" select="0"/>
    <xsl:with-param name="currentIndex" select="0"/>
  </xsl:call-template>-<xsl:call-template name="SelectToken">
    <xsl:with-param name="text" select="$dob"/>
    <xsl:with-param name="delimiter" select="string('/')"/>
    <xsl:with-param name="requiredIndex" select="1"/>
    <xsl:with-param name="currentIndex" select="0"/>
  </xsl:call-template>
  </xsl:template>
  
</xsl:stylesheet>