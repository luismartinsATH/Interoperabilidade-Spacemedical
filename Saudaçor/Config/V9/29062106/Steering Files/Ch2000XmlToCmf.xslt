<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">
  <xsl:template match="/">
    <Message>
      <Processing>
        <!-- Upload the CH2000 report to the server and update the
        database with the patient demographics. -->
        <Action type="UploadReport"/>
      </Processing>
      <Patient>
        <xsl:apply-templates/>
      </Patient>
      <Test>
        <StartDateTime>
          <xsl:call-template name="CH2000ToXmlDateTime">
            <xsl:with-param name="dateToConvert" select="//testDateValCd"/>
            <xsl:with-param name="timeToConvert" select="//testTimeValCd"/>
          </xsl:call-template>
        </StartDateTime>
        <RecorderType>ch2000</RecorderType>
      </Test>
      <Reports>
        <Report>
          <ReportType>ch2000</ReportType>
          <TestType>stress</TestType>
          <Status>Unconfirmed</Status>
        </Report>
      </Reports>
      <ArrayOfMeasurement xmlns="">
        <Measurement><Name>impressions</Name><Value><xsl:value-of select="/CH2000/impressionsValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>indication</Name><Value><xsl:value-of select="/CH2000/indicationValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>maxBp</Name><Value><xsl:value-of select="/CH2000/maxBpValCd" /></Value><Type>StringData</Type><Units>MillimetresOfMercury</Units><Status>R</Status></Measurement>
        <Measurement><Name>maxExercise</Name><Value><xsl:value-of select="/CH2000/maxExerciseValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>maxHr</Name><Value><xsl:value-of select="/CH2000/maxHrValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>maxStDev</Name><Value><xsl:value-of select="/CH2000/maxStDevValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>medications1</Name><Value><xsl:value-of select="/CH2000/medications1ValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>medications2</Name><Value><xsl:value-of select="/CH2000/medications2ValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>medications3</Name><Value><xsl:value-of select="/CH2000/medications3ValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>medications4</Name><Value><xsl:value-of select="/CH2000/medications4ValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>medications5</Name><Value><xsl:value-of select="/CH2000/medications5ValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>peakRpp</Name><Value><xsl:value-of select="/CH2000/peakRppValCd" /></Value><Type>Number</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>percentPred</Name><Value><xsl:value-of select="/CH2000/percentPredValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>protocol</Name><Value><xsl:value-of select="/CH2000/protocolValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>exerTime</Name><Value><xsl:call-template name="ConvertExerTimeToXmlDuration"><xsl:with-param name="time" select="/CH2000/exerTimeValCd" /></xsl:call-template></Value><Type>Number</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>ptHeight</Name><Value><xsl:value-of select="/CH2000/ptHeightValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>ptWeight</Name><Value><xsl:value-of select="/CH2000/ptWeightValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>resultsText</Name><Value><xsl:value-of select="/CH2000/resultsTextValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>stopReason</Name><Value><xsl:value-of select="/CH2000/stopReasonValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>testDate</Name><Value><xsl:call-template name="CH2000ToXmlDate"><xsl:with-param name="dateToConvert" select="/CH2000/testDateValCd"/></xsl:call-template></Value><Type>Date</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>testTime</Name><Value><xsl:call-template name="CH2000ToXmlTime"><xsl:with-param name="timeToConvert" select="/CH2000/testTimeValCd" /></xsl:call-template></Value><Type>Time</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>testType</Name><Value><xsl:value-of select="/CH2000/testTypeValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>exerDevice</Name><Value><xsl:value-of select="/CH2000/exerDeviceValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>ptComments</Name><Value><xsl:value-of select="/CH2000/ptCommentsValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
        <Measurement><Name>speedUnitsValCd</Name><Value><xsl:value-of select="/CH2000/speedUnitsValCd" /></Value><Type>StringData</Type><Units>Unspecified</Units><Status>R</Status></Measurement>
      </ArrayOfMeasurement>
    </Message>
    </xsl:template>

  <xsl:template match="ptIdNumberValCd">
    <!-- Patient Demographics -->
    <PatientID>
      <PatientNumber>
        <xsl:value-of select="."/>
      </PatientNumber>
    </PatientID>
  </xsl:template>

  <xsl:template match="ptFirstNameValCd">
    <GivenName>
      <xsl:value-of select="."/>
    </GivenName>
  </xsl:template>

  <xsl:template match="ptLastNameValCd">
    <FamilyName>
      <xsl:value-of select="."/>
    </FamilyName>
  </xsl:template>

  <xsl:template match="ptMiddleNameValCd">
    <MiddleInitials>
      <xsl:value-of select="."/>
    </MiddleInitials>
  </xsl:template>

  <xsl:template match="ptDobValCd">
    <!-- Convert from CH2000 format to XML Date format -->
    <DateOfBirth>
      <xsl:call-template name="CH2000ToXmlDate">
        <xsl:with-param name="dateToConvert" select="."/>
      </xsl:call-template>
    </DateOfBirth>
  </xsl:template>

  <xsl:template name="CH2000ToXmlDateTime">
    <xsl:param name="dateToConvert"/>
    <xsl:param name="timeToConvert"/>
    <xsl:choose>
      <!-- Guard against trying to convert an empty string -->
      <xsl:when test="string-length($dateToConvert)>0 or string-length($timeToConvert)>0">
        <xsl:call-template name="CH2000ToXmlDate">
          <xsl:with-param name="dateToConvert" select="$dateToConvert"/>
        </xsl:call-template>T<xsl:call-template name="CH2000ToXmlTime">
          <xsl:with-param name="timeToConvert" select="$timeToConvert"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CH2000ToXmlDate">
    <xsl:param name="dateToConvert"/>
    <!-- Make sure processsing only occurs if a date has been provided -->
    <xsl:choose>
      <xsl:when test="string-length($dateToConvert)=10">
        <xsl:variable name="Year" select="substring($dateToConvert, 7,4)"/>
        <!-- Find the order of the month and day components (e.g. either MM/DD/YYYY or DD/MM/YYYY) -->
        <xsl:choose>
          <xsl:when test="starts-with(//dateOrderValCd/text(), 'M')">
            <xsl:variable name="Month" select="substring($dateToConvert, 1,2)"/>
            <xsl:variable name="Day" select="substring($dateToConvert, 4,2)"/>
            <xsl:value-of select="concat($Year, '-', $Month, '-', $Day)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="Day" select="substring($dateToConvert, 1,2)"/>
            <xsl:variable name="Month" select="substring($dateToConvert, 4,2)"/>
            <xsl:value-of select="concat($Year, '-', $Month, '-', $Day)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="CH2000ToXmlTime">
    <xsl:param name="timeToConvert"/>
    <xsl:if test="string-length($timeToConvert)>0">
      <xsl:variable name="hours" select="substring($timeToConvert, 1, 2)"/>
      <xsl:variable name="mins" select="substring($timeToConvert, 4, 2)"/>
      <xsl:variable name="secs" select="substring($timeToConvert, 7, 2)"/>
      <xsl:value-of select="concat($hours, ':', $mins, ':', $secs)"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="ptSexValCd">
    <Gender>
      <xsl:call-template name="ConvertSex"/>
    </Gender>
  </xsl:template>

  <!-- Template used to convert sex from string
  representation to numeric representation -->
  <xsl:template name="ConvertSex">
    <xsl:choose>
      <xsl:when test="starts-with(child::text(),'M')">1</xsl:when>
      <xsl:when test="starts-with(child::text(),'F')">2</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="ConvertExerTimeToXmlDuration">
    <xsl:param name="time"/>
    <!-- (m)mm:ss to hh:mm:ss -->
    <xsl:value-of select="utils:Ch2000ToXmlDuration($time)"/>
  </xsl:template>
  
  <!-- Override implicit templates that cause the value of nodes to be copied to the result tree -->
  <xsl:template match="node()">
    <!-- Continue the processing by applying any matching templates -->
    <xsl:apply-templates/>
  </xsl:template>
  
</xsl:stylesheet>