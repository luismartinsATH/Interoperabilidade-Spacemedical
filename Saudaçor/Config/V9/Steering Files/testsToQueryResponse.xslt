<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cmf="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">
  <xsl:include href="CommonTemplates.xslt"/>

  <!-- PARAMS: -->
  <!-- Control ID (unique numeric ID for a ORU message) -->
  <xsl:param name="MessageID"/>
  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <root>
      <query>
        <ECGTitle />
        <ExamStartDate />
        <ExamEndDate />
        <Modality />
        <PerformingPhysician />
        <PatientName />
        <PatientID />
      </query>
      <result>
        <Code>Success</Code>
        <Message>
          <xsl:variable name="testNodes" select="/SentinelTests/ExtendedTest"/>
          <xsl:value-of select="count($testNodes)"/>
        </Message>
      </result>
      <records>
        <xsl:for-each select="/SentinelTests/ExtendedTest">
          <record>
            <PatientID><xsl:value-of select="Patient/PatientNumber"/></PatientID>
            <PatientName><xsl:value-of select="Patient/FamilyName"/>,<xsl:value-of select="Patient/GivenName"/></PatientName>
            <PatientSex>
              <xsl:variable name="gender" select="Patient/Gender"/>
              <xsl:value-of select="substring($gender, 1, 1)"/>
            </PatientSex>
            <PatientAge></PatientAge>
            <PatientAgeUnit></PatientAgeUnit>
            <PatientBirthDate>
              <xsl:variable name="dob" select="Patient/DateOfBirth/Date"/>
              <xsl:if test="string-length($dob) > 10">
                <xsl:value-of select="substring($dob, 1, 10)"/>
              </xsl:if>
            </PatientBirthDate>
            <!-- original line here <RequestDepartment></RequestDepartment> -->
            <RequestDepartment><xsl:value-of select="Patient/InPatientWard"/></RequestDepartment><!-- NEW FOR CARDIOEXPRESS TESTING-->
            <RequestDate>
              <xsl:variable name="requestedDate" select="OrderRequestedDate/DateTime"/>
              <xsl:if test="string-length($requestedDate) > 10">
                <xsl:value-of select="substring($requestedDate, 1, 10)"/>
              </xsl:if>
            </RequestDate>
            <RequestID><xsl:value-of select="OrderNumber"/></RequestID>
          </record>  
        </xsl:for-each>
      </records>
    </root>
  </xsl:template>
</xsl:stylesheet>