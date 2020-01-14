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
        <MiddleInitials></MiddleInitials>
        <DateOfBirth></DateOfBirth>
        <Gender></Gender>
        <Height unit="M"></Height>
        <Weight unit="KG"></Weight>
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
        <RecorderType></RecorderType>
        <TestStatus></TestStatus>
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

  <!-- The following templates assume the file name that contains
  data to be imported is formatted as follows:
  
  patientID.familyName.givenName.testType.pdf
  
  e.g.
  
  002.smith.george.resting.pdf
  
  -->
  
  <!-- Extract the family name from the second of the
  period-delimited elements of the PDF name. 
  In: 002.smith.george.resting.pdf
  Out: smith -->
  <xsl:template name="ExtractPatientFamilyName">
    <xsl:variable name="filename">
      <xsl:call-template name="GetReportFilename"/>
    </xsl:variable>
    <xsl:call-template name="SelectToken">
      <xsl:with-param name="text" select="$filename"/>
      <xsl:with-param name="delimiter">.</xsl:with-param>
      <xsl:with-param name="requiredIndex">1</xsl:with-param>
      <xsl:with-param name="currentIndex">0</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- Extract the given name from the third of the
  period-delimited elements of the PDF name. 
  In: 002.smith.george.resting.pdf
  Out: george -->
  <xsl:template name="ExtractPatientGivenName">
    <xsl:variable name="filename">
      <xsl:call-template name="GetReportFilename"/>
    </xsl:variable>
    <xsl:call-template name="SelectToken">
      <xsl:with-param name="text" select="$filename"/>
      <xsl:with-param name="delimiter">.</xsl:with-param>
      <xsl:with-param name="requiredIndex">2</xsl:with-param>
      <xsl:with-param name="currentIndex">0</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- Extract the patient ID from the first of the
  period-delimited elements of the PDF name. 
  In: 002.smith.george.resting.pdf
  Out: 002 -->
  <xsl:template name="ExtractPatientID">
    <xsl:variable name="filename">
      <xsl:call-template name="GetReportFilename"/>
    </xsl:variable>
    <xsl:call-template name="SelectToken">
      <xsl:with-param name="text" select="$filename"/>
      <xsl:with-param name="delimiter">.</xsl:with-param>
      <xsl:with-param name="requiredIndex">0</xsl:with-param>
      <xsl:with-param name="currentIndex">0</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- Extract the test type from the fourth of the
  period-delimited elements of the PDF name. 
  In: 002.smith.george.resting.pdf
  Out: resting -->
  <xsl:template name="ExtractTestType">
    <xsl:variable name="filename">
      <xsl:call-template name="GetReportFilename"/>
    </xsl:variable>
    <xsl:call-template name="SelectToken">
      <xsl:with-param name="text" select="$filename"/>
      <xsl:with-param name="delimiter">.</xsl:with-param>
      <xsl:with-param name="requiredIndex">3</xsl:with-param>
      <xsl:with-param name="currentIndex">0</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
</xsl:stylesheet>