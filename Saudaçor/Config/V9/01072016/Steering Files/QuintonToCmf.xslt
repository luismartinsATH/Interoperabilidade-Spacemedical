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
          <TestType>stress</TestType>
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