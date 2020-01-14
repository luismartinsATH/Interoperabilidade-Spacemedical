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
            <xsl:call-template name="ExtractPatientID"/>
          </PatientNumber>
          <PatientNumber2></PatientNumber2>
        </PatientID>
        <GivenName>
          <xsl:call-template name="ExtractPatientGivenName"/>
        </GivenName>
        <FamilyName>
          <xsl:call-template name="ExtractPatientFamilyName"/>
        </FamilyName>
        <MaidenName></MaidenName>
        <MiddleInitials>
          <xsl:call-template name="ExtractMiddleInitial"/>
        </MiddleInitials>
        <DateOfBirth></DateOfBirth>
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
        <StartDateTime>
          <xsl:call-template name="ExtractRecordingDateTime"/>
        </StartDateTime>
        <RecordingDuration></RecordingDuration>
        <RecorderModel>Philips StressVUE</RecorderModel>
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
          <!-- Will need SMS to Sentinel GUID conversions for these values -->
          <TestType>
            <xsl:call-template name="ExtractTestType"/>
          </TestType>
          <RecordingDateTime></RecordingDateTime>
          <ReportFormat></ReportFormat>
          <ReportType>
            <xsl:call-template name="ExtractTestType"/>
          </ReportType>
          <Status>Unconfirmed</Status>
        </Report>
      </Reports>
    </Message>
  </xsl:template>

  <!-- The following templates parse PDF filenames of the following format:
  
  xx_PatientID[Date+Time]FirstName_MiddleInitial_LastName
  
  where xx is either ZH or SV for Holter reports and Stress reports, respectively
  and Date+Time refers to the start date and time of the recording in YYYYMMDD, HHMM format.
  
  e.g.
  
  ZH_101[20050516+1030]Rufus_T_Firefly.pdf
  
  -->
  
  <!-- Extracts the patient family name from the last of the underscore-delimited
  elements of the file name.
  In: ZH_101[20050516+1030]Rufus_T_Firefly.pdf 
  Out: Firefly -->
  <xsl:template name="ExtractPatientFamilyName">
    <xsl:variable name="filename">
      <xsl:call-template name="GetReportFilename"/>
    </xsl:variable>

    <xsl:variable name="filenameWithoutExtension" select="substring-before($filename, '.')"/>
    
    <xsl:call-template name="SelectToken">
      <xsl:with-param name="text" select="$filenameWithoutExtension"/>
      <xsl:with-param name="delimiter">_</xsl:with-param>
      <xsl:with-param name="requiredIndex">3</xsl:with-param>
      <xsl:with-param name="currentIndex">0</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- Extracts the patient given name from between the ']' character
  and the following underscore.
  In: ZH_101[20050516+1030]Rufus_T_Firefly.pdf 
  Out: Rufus -->
  <xsl:template name="ExtractPatientGivenName">
    <xsl:variable name="filename">
      <xsl:call-template name="GetReportFilename"/>
    </xsl:variable>
    <xsl:value-of select="substring-before(substring-after($filename, ']'), '_')"/>
  </xsl:template>

  <!-- Extracts the patient ID from the fourth character of the filename to 
  the '[' character.
  In: ZH_101[20050516+1030]Rufus_T_Firefly.pdf 
  Out: 101 -->
  <xsl:template name="ExtractPatientID">
    <xsl:variable name="filename">
      <xsl:call-template name="GetReportFilename"/>
    </xsl:variable>
    <xsl:value-of select="substring-before(substring($filename, 4), '[')"/>
  </xsl:template>

  <!-- Infers the test type from the first two characters of the filename.
  In: ZH_101[20050516+1030]Rufus_T_Firefly.pdf 
  Out: holter -->
  <xsl:template name="ExtractTestType">
    <xsl:variable name="filename">
      <xsl:call-template name="GetReportFilename"/>
    </xsl:variable>
    <xsl:variable name="TestIndicator">
      <xsl:value-of select="substring-before($filename, '_')"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$TestIndicator='SV'">stress</xsl:when>
      <xsl:otherwise>holter</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Extracts the recording data and time from between the square braces and
  converts the result to an XSD DateTime.
  In: ZH_101[20050516+1030]Rufus_T_Firefly.pdf 
  Out: 2005-05-16T10:30 -->
  <xsl:template name="ExtractRecordingDateTime">
    <xsl:variable name="filename">
      <xsl:call-template name="GetReportFilename"/>
    </xsl:variable>
    <xsl:variable name="recordingDateTime" select="substring-before(substring-after($filename, '['), ']')"/>
    <xsl:variable name="date" select="substring($recordingDateTime, 1, 8)"/>
    <xsl:variable name="time" select="substring($recordingDateTime, 10, 4)"/>
    <xsl:variable name="hl7DateTime" select="concat($date, $time)"/>
    <xsl:call-template name="FunctionHl7ToXmlDateTime">
      <xsl:with-param name="dateTime" select="$hl7DateTime"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Extracts the patient's middle initial from the third underscore-delimited
  element within the file name. 
  In: ZH_101[20050516+1030]Rufus_T_Firefly.pdf 
  Out: T -->
  <xsl:template name="ExtractMiddleInitial">
    <xsl:variable name="filename">
      <xsl:call-template name="GetReportFilename"/>
    </xsl:variable>
    <xsl:call-template name="SelectToken">
      <xsl:with-param name="text" select="$filename"/>
      <xsl:with-param name="delimiter">_</xsl:with-param>
      <xsl:with-param name="requiredIndex">2</xsl:with-param>
      <xsl:with-param name="currentIndex">0</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
</xsl:stylesheet>