<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:utils="urn:CodeUtils">

  <!-- The following template takes  a ten digit number and formats it
  according to the NHS Number format: xxx-xxx-xxxx 
  Example input: 0123456789 Example output: 012-345-6789 -->
  <xsl:template name="FunctionFormatPatientID">
    <xsl:param name="ID"/>
    <xsl:if test="string-length($ID) = 10">
      <xsl:variable name="firstTuple" select="substring($ID, 1, 3)"/>
      <xsl:variable name="secondTuple" select="substring($ID, 4, 3)"/>
      <xsl:variable name="thirdTuple" select="substring($ID, 7, 4)"/>
      <xsl:value-of select="concat($firstTuple, ' ', $secondTuple, ' ', $thirdTuple)"/>
    </xsl:if>
  </xsl:template>

  <!-- Template that converts the data time passed to it from HL7 to XML format -->
  <xsl:template name="FunctionHl7ToXmlDateTime">
    <xsl:param name="dateTime"/>
    <xsl:choose>
      <xsl:when test="string-length($dateTime) > 11">
        <xsl:variable name="Year" select="substring($dateTime, 1,4)"/>
        <xsl:variable name="Month" select="substring($dateTime, 5,2)"/>
        <xsl:variable name="Day" select="substring($dateTime, 7,2)"/>
        <xsl:variable name="Hours" select="substring($dateTime, 9,2)"/>
        <xsl:variable name="Minutes" select="substring($dateTime, 11,2)"/>
        <xsl:value-of select="concat($Year, '-', $Month, '-', $Day, 'T', $Hours, ':', $Minutes, ':', '00')"/>
      </xsl:when>
      <xsl:when test="$dateTime='&quot;&quot;'">&quot;&quot;</xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Template that converts the data passed to it from HL7 to XML format -->
  <xsl:template name="FunctionHl7ToXmlDate">
    <xsl:param name="date"/>
    <xsl:choose>
      <xsl:when test="string-length($date) > 7">
        <xsl:variable name="Year" select="substring($date, 1,4)"/>
        <xsl:variable name="Month" select="substring($date, 5,2)"/>
        <xsl:variable name="Day" select="substring($date, 7,2)"/>
        <xsl:value-of select="concat($Year, '-', $Month, '-', $Day)"/>
      </xsl:when>
      <xsl:when test="$date='&quot;&quot;'">&quot;&quot;</xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Template that converts the data passed to it from HL7 to XML format
  or returns the current date in XML format if the parameter is empty -->
  <xsl:template name="FunctionHl7ToXmlDateOrNow">
    <xsl:param name="date"/>
    <xsl:choose>
      <xsl:when test="string-length($date) > 8">
        <xsl:variable name="Year" select="substring($date, 1,4)"/>
        <xsl:variable name="Month" select="substring($date, 5,2)"/>
        <xsl:variable name="Day" select="substring($date, 7,2)"/>
        <xsl:variable name="Hours" select="substring($date, 9,2)"/>
        <xsl:variable name="Minutes" select="substring($date, 11,2)"/>
        <xsl:value-of select="concat($Year, '-', $Month, '-', $Day, 'T', $Hours, ':', $Minutes, ':', '00')"/>
      </xsl:when>
      <xsl:when test="string-length($date) > 0">
        <xsl:variable name="Year" select="substring($date, 1,4)"/>
        <xsl:variable name="Month" select="substring($date, 5,2)"/>
        <xsl:variable name="Day" select="substring($date, 7,2)"/>
        <xsl:value-of select="concat($Year, '-', $Month, '-', $Day)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="Year" select="substring($now, 1,4)"/>
        <xsl:variable name="Month" select="substring($now, 5,2)"/>
        <xsl:variable name="Day" select="substring($now, 7,2)"/>
        <xsl:variable name="Hours" select="substring($now, 9,2)"/>
        <xsl:variable name="Minutes" select="substring($now, 11,2)"/>
        <xsl:value-of select="concat($Year, '-', $Month, '-', $Day, 'T', $Hours, ':', $Minutes, ':', '00')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Convert from XML date format to HL7 date format. -->
  <xsl:template name="FunctionXmlToHl7Date">
    <xsl:param name="date"/>
    <xsl:if test="string-length($date) > 0">
      <xsl:variable name="Year" select="substring($date, 1,4)"/>
      <xsl:variable name="Month" select="substring($date, 6,2)"/>
      <xsl:variable name="Day" select="substring($date, 9,2)"/>
      <xsl:value-of select="concat($Year, $Month, $Day)"/>
    </xsl:if>
  </xsl:template>

  <!-- Convert from XML time format to HL7 date time format. -->
  <xsl:template name="FunctionXmlToHl7DateTime">
    <xsl:param name="dateTime"/>
    <xsl:if test="string-length($dateTime) > 0">
      <xsl:variable name="Year" select="substring($dateTime, 1,4)"/>
      <xsl:variable name="Month" select="substring($dateTime, 6,2)"/>
      <xsl:variable name="Day" select="substring($dateTime, 9,2)"/>
      <xsl:variable name="Hours" select="substring($dateTime, 12,2)"/>
      <xsl:variable name="Minutes" select="substring($dateTime, 15,2)"/>
      <xsl:variable name="Seconds" select="substring($dateTime, 18,2)"/>
      <xsl:value-of select="concat($Year, $Month, $Day, $Hours, $Minutes, $Seconds)"/>
    </xsl:if>
  </xsl:template>

  <!-- Convert from XML time format to HL7 date time format. -->
  <xsl:template name="FunctionXmlToHl7Time">
    <xsl:param name="time"/>
    <xsl:if test="string-length($time) > 0">
      <xsl:variable name="Hours" select="substring($time, 1,2)"/>
      <xsl:variable name="Minutes" select="substring($time, 4,2)"/>
      <xsl:variable name="Seconds" select="substring($time, 7,2)"/>
      <xsl:value-of select="concat($Hours, $Minutes, $Seconds)"/>
    </xsl:if>
  </xsl:template>

  <!-- Convert HL7 visit class to a Sentinel case type. -->
  <xsl:template name="FunctionHl7toSentinelClass">
    <xsl:param name="class"/>
    <xsl:choose>
      <xsl:when test="$class='I' or $class='S'">InPatient</xsl:when>
      <xsl:when test="$class='A' or $class='O'">OutPatient</xsl:when>
      <xsl:when test="$class='V'">InPatient</xsl:when>
      <xsl:when test="$class='N'">InPatient</xsl:when>
      <xsl:when test="$class='TS'">InPatient</xsl:when>
      <xsl:when test="$class='VS'">InPatient</xsl:when>
      <xsl:when test="$class='TK'">OutPatient</xsl:when>
      <xsl:otherwise>InPatient</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Template used to convert sex from Sentinel numerical code
  representation to a character -->
  <xsl:template name="FunctionSentinelToHl7GenderCode">
    <xsl:param name="gender"/>
    <xsl:choose>
      <xsl:when test="$gender='Male'">M</xsl:when>
      <xsl:when test="$gender='Female'">F</xsl:when>
      <xsl:otherwise>O</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- For a merge operation, the following template extracts the IDs of the patients to be
  merged (i.e. the patients whose tests, etc. will be copied over to the patient identified in the PID
  segment). -->
  <xsl:template name="GetPatientsToMerge">
    <xsl:for-each select="/Hl7XmlMessage/MRG">
      <SourcePatient xmlns="urn:dmr-cmf">
        <xsl:value-of select="MRG.1"/>
      </SourcePatient>
    </xsl:for-each>
  </xsl:template>

  <!-- For a move operation, the following template extracts the patient and case IDs 
  of the patients to be moved (i.e. the patients whose case numbers (and associated tests) 
  will be copied over to the patient identified in the PID segment). -->
  <xsl:template name="GetPatientsToMove">
    <xsl:for-each select="/Hl7XmlMessage/MRG">
      <SourcePatient xmlns="urn:dmr-cmf">
        <ID>
          <xsl:value-of select="MRG.3"/>
        </ID>
        <VisitNumber>
          <xsl:value-of select="MRG.5"/>
        </VisitNumber>
      </SourcePatient>
    </xsl:for-each>
  </xsl:template>

  <!-- Gets all the cases to be moved from one or more MRG segments, as well
  as any new numberings, from PV1 segments, to use once the cases have been moved -->
  <xsl:template name="GetCasesToMove">
    <SourcePatient xmlns="urn:dmr-cmf">
      <xsl:value-of select="/Hl7XmlMessage/MRG/MRG.1"/>
    </SourcePatient>
    <xsl:for-each select="/Hl7XmlMessage/node()">
      <xsl:choose>
        <xsl:when test="name()='MRG'">
          <SourceVisitNumber xmlns="urn:dmr-cmf">
            <xsl:value-of select="MRG.5"/>
          </SourceVisitNumber>
        </xsl:when>
        <xsl:when test="name()='PV1'">
          <DestinationVisitNumber xmlns="urn:dmr-cmf">
            <xsl:value-of select="PV1.19"/>
          </DestinationVisitNumber>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!-- Gets all the cases to be merged from one or more MRG segments,
  and the cases to merge them into from PV1 segments. -->
  <xsl:template name="GetCasesToMerge">
    <SourcePatient xmlns="urn:dmr-cmf">
      <xsl:value-of select="/Hl7XmlMessage/MRG/MRG.1"/>
    </SourcePatient>
    <xsl:for-each select="/Hl7XmlMessage/node()">
      <xsl:choose>
        <xsl:when test="name()='MRG'">
          <SourceVisitNumber xmlns="urn:dmr-cmf">
            <xsl:value-of select="MRG.5"/>
          </SourceVisitNumber>
        </xsl:when>
        <xsl:when test="name()='PV1'">
          <DestinationVisitNumber xmlns="urn:dmr-cmf">
            <xsl:value-of select="PV1.19"/>
          </DestinationVisitNumber>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <!--Extracts the height and the height unit-->
  <xsl:template name="ExtractPatientHeight">
    <xsl:for-each select="/Hl7XmlMessage/OBX">
      <xsl:if test="OBX.3/OBX.3.2= 'HEIGHT' ">
        <xsl:call-template name="ConvertHeightToM"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!--Coverts the height from the given format to Metres-->
  <xsl:template name="ConvertHeightToM">
    <xsl:param name="unit" select="OBX.6"/>
    <xsl:choose>
      <xsl:when test="$unit='inches' or $unit=INCHES or $unit=inch or $unit=INCH">
        <xsl:value-of select="OBX.5 div 39.37007874"/>
      </xsl:when>
      <xsl:when test="$unit='cm' or $unit='CM'">
        <xsl:value-of select="OBX.5 div 100"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="OBX.5"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!--Extracts the weight and the weight unit-->
  <xsl:template name="ExtractPatientWeight">
    <xsl:for-each select="/Hl7XmlMessage/OBX">
      <xsl:if test="OBX.3/OBX.3.2= 'WEIGHT'">
        <xsl:call-template name="ConvertWeightToM"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!--Coverts the weight from the given format to grams-->
  <xsl:template name="ConvertWeightToM">
    <xsl:param name="unit" select="OBX.6"/>
    <xsl:choose>
      <xsl:when test="$unit='pounds' or $unit=POUNDS or $unit='pound' or $unit='POUND' or $unit='lbs' or $unit='LBS' or $unit='lb' or $unit='LB'">
        <xsl:value-of select="OBX.5 div  2204.622622"/>
      </xsl:when>
      <xsl:when test="$unit='stones' or $unit='STONES' or $unit='stone' or $unit='STONE'">
        <xsl:value-of select="OBX.5 *  6350.29318"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="OBX.5 * 1000"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Example template that prefixes the patient ID to the PDF
  report named passed to it. -->
  <xsl:template name="RenameReportFile" xmlns:cmf="urn:dmr-cmf">
    <xsl:param name="CurrentName"/>
    <xsl:variable name="givenName" select="/cmf:Message/cmf:Patient/cmf:GivenName"/>
    <xsl:variable name="patientId" select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:PatientNumber"/>
    <xsl:variable name="arguments" select="concat($givenName, ',', $patientId)"/>
    <xsl:value-of select="utils:RenamePdf($CurrentName, '{0}-{1}.pdf', $arguments)" />
  </xsl:template>

  <!-- Template used to convert sex from string representation to numeric representation -->
  <xsl:template name="FunctionHl7ToSentinelGender">
    <xsl:param name="gender"/>
    <xsl:choose>
      <xsl:when test="starts-with($gender,'U')">0</xsl:when>
      <xsl:when test="starts-with($gender,'O')">0</xsl:when>
      <xsl:when test="starts-with($gender,'M')">1</xsl:when>
      <xsl:when test="starts-with($gender,'F')">2</xsl:when>
      <xsl:otherwise>2</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Determines if the report is F (final) or R (unverified results).
  If the report has been signed, it is final, otherwise it is unverified. -->
  <xsl:template name="FunctionCmfReportStatusToHl7">
    <xsl:param name="interpreter" />
    <xsl:choose>
      <xsl:when test="string-length($interpreter)>0">F</xsl:when>
      <xsl:otherwise>R</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Mapping used to turn measurement units into a suitable form for use
  in OBX segments.  Where possible, SI units should be used. -->
  <xsl:template name="FunctionSentinelToHl7Units">
    <xsl:param name="unit"/>
    <xsl:choose>
      <xsl:when test="$unit='Beats'">beats</xsl:when>
      <xsl:when test="$unit='Events'">events</xsl:when>
      <xsl:when test="$unit='BeatsPerMinute'">bpm</xsl:when>
      <xsl:when test="$unit='Millimetres'">mm</xsl:when>
      <xsl:when test="$unit='Milliseconds'">ms</xsl:when>
      <xsl:when test="$unit='MillimetresPerMillisecond'">mm/ms</xsl:when>
      <xsl:when test="$unit='Seconds'">s</xsl:when>
      <xsl:when test="$unit='Minutes'">Min</xsl:when>
      <xsl:when test="$unit='Hours'">Hr</xsl:when>
      <xsl:when test="$unit='Percent'">percent</xsl:when>
      <xsl:when test="$unit='ZeroOrOne'">0 or 1</xsl:when>
      <xsl:when test="$unit='ZeroToTwo'">0 - 2</xsl:when>
      <xsl:when test="$unit='Count'">count</xsl:when>
      <xsl:when test="$unit='Index'">index</xsl:when>
      <xsl:when test="$unit='MillimetresOfMercury'">mmHg</xsl:when>
      <xsl:when test="$unit='MillimetresOfMercuryPerMinute'">mmHg/min</xsl:when>
      <xsl:when test="$unit='Metres'">m</xsl:when>
      <xsl:when test="$unit='MetresPerSecond'">m/sec</xsl:when>
      <xsl:when test="$unit='MicrovoltsPerMillisecond'">uV/s</xsl:when>
      <xsl:when test="$unit='MillivoltsPerSecond'">mV/s</xsl:when>
      <xsl:when test="$unit='MillivoltsPerMillimetre'">mV/mm</xsl:when>
      <xsl:when test="$unit='MillivoltsSeconds'">mVs</xsl:when>
      <xsl:when test="$unit='Samples'">samples</xsl:when>
      <xsl:when test="$unit='Millivolts'">mV</xsl:when>
      <xsl:when test="$unit='Microvolts'">uV</xsl:when>
      <xsl:when test="$unit='Degrees'">deg</xsl:when>
      <xsl:when test="$unit='Hertz'">Hz</xsl:when>
      <xsl:when test="$unit='Watts'">W</xsl:when>
      <xsl:when test="$unit='WattsPerKilogram'">W/kg</xsl:when>
      <xsl:when test="$unit='METs'">METs</xsl:when>
      <xsl:when test="$unit='Unspecified'"></xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Mapping between the data types used in analyser measurements 
  and HL7 data types. -->
  <xsl:template name="FunctionSentinelToHl7DataTypes">
    <xsl:param name="type"/>
    <xsl:param name="value"/>
    <xsl:choose>
      <xsl:when test="$type='ImpresarioDateTime'">ST</xsl:when>
      <xsl:when test="$type='Date' and contains($value, '/')">ST</xsl:when>
      <xsl:when test="$type='Date'">DT</xsl:when>
      <xsl:when test="$type='Time'">TM</xsl:when>
      <xsl:when test="$type='DateTime' and contains($value, '/')">ST</xsl:when>
      <xsl:when test="$type='DateTime'">DTM</xsl:when>
      <xsl:when test="$type='StringData'">ST</xsl:when>
      <xsl:when test="$type='Duration'">TM</xsl:when>
      <xsl:when test="$type='Number'">NM</xsl:when>
      <xsl:when test="$type='ShortInteger'">NM</xsl:when>
      <xsl:when test="$type='Integer'">NM</xsl:when>
      <xsl:when test="$type='LongInteger'">NM</xsl:when>
      <xsl:when test="$type='DoublePrecision'">NM</xsl:when>
      <xsl:when test="$type='FloatingPoint'">NM</xsl:when>
      <xsl:when test="$type='Unspecified'"></xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Template used to convert measurement values to their HL7 equivalent format.  -->
  <xsl:template name="ConvertMeasurementValueToHl7">
    <xsl:param name="valueToConvert"/>
    <xsl:param name="valueType"/>
    <xsl:choose>
      <!-- Hack to stop impresario dates from being manipulated as they are
        in a differnt format from other measurement sources. -->
      <xsl:when test="$valueType='Date' and not(contains($valueToConvert, '/'))">
        <xsl:call-template name="FunctionXmlToHl7Date">
          <xsl:with-param name="date" select="$valueToConvert"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$valueType='Time'">
        <xsl:call-template name="FunctionXmlToHl7Time">
          <xsl:with-param name="time" select="$valueToConvert"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$valueType='Date' and contains($valueToConvert, '/')">
        <xsl:value-of select="$valueToConvert"/>
      </xsl:when>
      <xsl:when test="$valueType='Time'">
        <xsl:call-template name="FunctionXmlToHl7Time">
          <xsl:with-param name="time" select="$valueToConvert"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$valueType='Duration'">
        <!-- Don't see a suitable HL7 data type for durations.  Will, for now,
        just output the XML duration unchanged.-->
        <!--
        <xsl:call-template name="FunctionXmlToHl7Duration">
          <xsl:with-param name="time" select="$valueToConvert"/>
        </xsl:call-template>
        -->
        <xsl:value-of select="$valueToConvert"/>
      </xsl:when>
      <xsl:when test="$valueType='DateTime'">
        <xsl:call-template name="FunctionXmlToHl7DateTime">
          <xsl:with-param name="dateTime" select="$valueToConvert"/>
        </xsl:call-template>
      </xsl:when>
      <!-- No conversion necessary for the following types: -->
      <xsl:when test="$valueType='StringData' or $valueType='Number' 
                or $valueType='ShortInteger' or $valueType='Integer' or $valueType='LongInteger' 
                or $valueType='DoublePrecision' or $valueType='FloatingPoint' or $valueType='ImpresarioDateTime'
                or $valueType='Unspecified'">
        <xsl:value-of select="$valueToConvert"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Case conversion templates for en-us and en-uk.
  Unfortunately, Microsoft's XSLT implementation doesn't support XPath v2.0 and so
  upper-case() and lower-case() functions are not supported. -->
  <xsl:template name="FunctionToUpperCase">
    <xsl:param name="stringToConvert"/>
    <xsl:value-of select="translate($stringToConvert, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
  </xsl:template>

  <xsl:template name="FunctionToLowerCase">
    <xsl:param name="stringToConvert"/>
    <xsl:value-of select="translate($stringToConvert, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
  </xsl:template>

  <!-- Strips leading zeros from the inputted string. -->
  <xsl:template name="FunctionStripLeadingZeros">
    <xsl:param name="stringToStrip"/>
    <xsl:choose>
      <xsl:when test="starts-with($stringToStrip, '0')">
        <xsl:call-template name="FunctionStripLeadingZeros">
          <xsl:with-param name="stringToStrip" select="substring($stringToStrip, 2)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$stringToStrip"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Extracts the filename of a PDF report from a full path.
  This template should only be used in steering files that are
  applied to to incoming data produced by the MetadataToBodyTransform transformation. -->
  <xsl:template name="GetReportFilename">
    <xsl:call-template name="substring-after-last">
      <!-- Retrieve the full path from the location it's put in by MetadataToBodyTransform -->
      <xsl:with-param name="input" select="/MessageMetadata/Filename"/>
      <xsl:with-param name="substr">\</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="GetReportFilenameEx">
    <xsl:param name="fullPath"/>
    <xsl:call-template name="substring-after-last">
      <xsl:with-param name="input" select="$fullPath"/>
      <xsl:with-param name="substr">\</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- Translates a hexidecimal number into a decimal value.
  The initial value of the sum parameter should be 0. -->
  <xsl:template name="HexToDec">
    <xsl:param name="hexValue"/>
    <xsl:param name="sum"/>

    <xsl:choose>
      <xsl:when test="string-length($hexValue) > 0">

        <xsl:variable name="nextDigit" select="substring($hexValue, 1, 1)"/>
        <xsl:variable name="decimalDigit">
          <xsl:call-template name="HexToDecDigit">
            <xsl:with-param name="hexDigit" select="$nextDigit"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="coefficient">
          <xsl:call-template name="RaiseToPowerOf">
            <xsl:with-param name="base" select="16"/>
            <xsl:with-param name="exponent" select="string-length($hexValue) - 1"/>
            <xsl:with-param name="total" select="16"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="decimalValue" select="$decimalDigit * $coefficient"/>

        <xsl:call-template name="HexToDec">
          <xsl:with-param name="hexValue" select="substring($hexValue, 2)"/>
          <xsl:with-param name="sum" select="$sum + $decimalValue"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$sum"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Translates a single hex digit into a decimal digit. -->
  <xsl:template name="HexToDecDigit">
    <xsl:param name="hexDigit"/>
    <xsl:choose>
      <xsl:when test="$hexDigit='A' or $hexDigit='a'">10</xsl:when>
      <xsl:when test="$hexDigit='B' or $hexDigit='b'">11</xsl:when>
      <xsl:when test="$hexDigit='C' or $hexDigit='c'">12</xsl:when>
      <xsl:when test="$hexDigit='D' or $hexDigit='d'">13</xsl:when>
      <xsl:when test="$hexDigit='E' or $hexDigit='e'">14</xsl:when>
      <xsl:when test="$hexDigit='F' or $hexDigit='f'">15</xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$hexDigit"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Exponentiation template.
  The initial value of the total parameter should be equal to the base parameter. -->
  <xsl:template name="RaiseToPowerOf">
    <xsl:param name="base"/>
    <xsl:param name="exponent"/>
    <xsl:param name="total"/>
    <xsl:choose>
      <xsl:when test="$exponent = 0">1</xsl:when>
      <xsl:when test="$exponent = 1">
        <xsl:value-of select="$total"/>
      </xsl:when>
      <xsl:when test="$exponent > 1">
        <xsl:call-template name="RaiseToPowerOf">
          <xsl:with-param name="base" select="$base"/>
          <xsl:with-param name="exponent" select="$exponent - 1"/>
          <xsl:with-param name="total" select="$total * $base"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <!-- Selects the nth token from the inputted string: e.g. "hello.there.world", ., 1, 0,
  would return "there" -->
  <xsl:template name="SelectToken">
    <xsl:param name="text"/>
    <xsl:param name="delimiter"/>
    <xsl:param name="requiredIndex"/>
    <xsl:param name="currentIndex"/>

    <xsl:choose>
      <!-- Base case -->
      <xsl:when test="$requiredIndex = $currentIndex">
        <xsl:call-template name="Head">
          <xsl:with-param name="text" select="$text"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
        </xsl:call-template>
      </xsl:when>

      <!-- Recursive case -->
      <xsl:otherwise>

        <xsl:variable name="tail">
          <xsl:call-template name="Tail">
            <xsl:with-param name="text" select="$text"/>
            <xsl:with-param name="delimiter" select="$delimiter"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:call-template name="SelectToken">
          <xsl:with-param name="text" select="$tail"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
          <xsl:with-param name="requiredIndex" select="$requiredIndex"/>
          <xsl:with-param name="currentIndex" select="$currentIndex + 1"/>
        </xsl:call-template>

      </xsl:otherwise>

    </xsl:choose>
  </xsl:template>

  <!-- Head and Tail templates that are useful when iterating
  through lists. -->
  <xsl:template name="Head">
    <xsl:param name="text"/>
    <xsl:param name="delimiter"/>
    <xsl:choose>
      <xsl:when test="contains($text, $delimiter)">
        <xsl:value-of select="substring-before($text, $delimiter)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="Tail">
    <xsl:param name="text"/>
    <xsl:param name="delimiter"/>
    <xsl:value-of select="substring-after($text, $delimiter)"/>
  </xsl:template>

  <!-- Returns the substring before the last occurance of
  an inputted delimiter.
  e.g In: "102.John.Doe.Holter.pdf", '.'
  Out: 102.John.Doe.Holter -->
  <xsl:template name="substring-before-last">
    <xsl:param name="input"/>
    <xsl:param name="substr"/>
    <xsl:if test="$substr and contains($input, $substr)">
      <xsl:variable name="temp" select="substring-after($input, $substr)"/>
      <xsl:value-of select="substring-before($input, $substr)"/>
      <xsl:if test="contains($temp, $substr)">
        <xsl:value-of select="$substr"/>
        <xsl:call-template name="substring-before-last">
          <xsl:with-param name="input" select="$temp"/>
          <xsl:with-param name="substr" select="$substr"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <!-- Returns the substring after the last occurance of
  an inputted delimiter.
  e.g In: "102.John.Doe.Holter.pdf", '.'
  Out: pdf -->
  <xsl:template name="substring-after-last">
    <xsl:param name="input"/>
    <xsl:param name="substr"/>
    <xsl:variable name="temp" select="substring-after($input, $substr)"/>
    <xsl:choose>
      <xsl:when test="$substr and contains($temp, $substr)">
        <xsl:call-template name="substring-after-last">
          <xsl:with-param name="input" select="$temp"/>
          <xsl:with-param name="substr" select="$substr"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$temp"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- THE FOLLOWING TEMPLATES ARE SYMMETRICAL (INCOMING AND OUTGOING).  IF ONE IS
  UPDATED, THE OTHERS OUGHT TO BE UPDATED TOO.-->

  <!-- Convert from the Universal Service ID (HL7) to a procedure that Sentinel understands. -->
  <xsl:template name="FunctionHl7ToSentinelProcedure">
    <xsl:param name="procedure"/>
    <xsl:choose>
      <xsl:when test="$procedure='C40301^ECG SIMPLES DE 12 DERIVACOES'">resting</xsl:when>  <!-- Alterado por LM -->
      <xsl:when test="$procedure='18752-6^LN'">stress</xsl:when>
      <xsl:when test="$procedure='18754-2^LN'">holter</xsl:when>
      <xsl:when test="starts-with($procedure,'blood')">blood pressure</xsl:when>
      <xsl:when test="starts-with($procedure,'Rhythm')">rhythm</xsl:when>
      <xsl:when test="starts-with($procedure,'event')">other</xsl:when>
      <!-- Pass procedure name that did not match through unchanged as it
      will be put into an "unrecognised procedure" error message in the event log. -->
      <xsl:otherwise>
        <xsl:value-of select="$procedure"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Converts the test type GUID to an HL7 Universal Service ID -->
  <xsl:template name="FunctionSentinelTestTypeToHl7">
    <xsl:param name="procedure"/>
    <xsl:param name="testTypeName"/>
    <xsl:choose>
 <!--     <xsl:when test="starts-with($procedure, 'e83f0')">11524-0</xsl:when> -->
      <xsl:when test="starts-with($procedure, 'e83f0')">C40301^ECG SIMPLES DE 12 DERIVACOES</xsl:when>
      <xsl:when test="starts-with($procedure, 'b3517')">18752-6</xsl:when>
      <xsl:when test="starts-with($procedure, '48dd5')">18754-2</xsl:when>
      <xsl:when test="starts-with($procedure, '769c3')">blood pressure</xsl:when>
      <xsl:when test="starts-with($procedure, '8d91e')">Rhythm</xsl:when>
      <xsl:when test="starts-with($procedure, 'd069769a')">
        <xsl:value-of select="$testTypeName"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="FunctionSentinelTestTypeToHl7CodeSet">
    <xsl:param name="procedure"/>
    <xsl:choose>
      <xsl:when test="starts-with($procedure, 'e83f0')">LN</xsl:when>
      <xsl:when test="starts-with($procedure, 'b3517')">LN</xsl:when>
      <xsl:when test="starts-with($procedure, '48dd5')">LN</xsl:when>
      <xsl:when test="starts-with($procedure, '769c3')"></xsl:when>
      <xsl:when test="starts-with($procedure, '8d91e')"></xsl:when>
      <xsl:when test="starts-with($procedure, 'a8d82')"></xsl:when>
    </xsl:choose>
  </xsl:template>

<!-- função desenvolvida para retirar o ID do paciente -->
<xsl:template name="FunctionExtractPatientID">
        <xsl:variable name="ExtractedPatientID">
        <xsl:for-each select="/Hl7XmlMessage/PID/PID.3/child::*">
                 <xsl:if test="contains(.,'RNU')">
                          <xsl:call-template name="ExtractID_1">
                          <xsl:with-param name="IdPatient"> 
                          <xsl:value-of select="position()-3"/>
                           </xsl:with-param>
                           </xsl:call-template>
                     </xsl:if>
          </xsl:for-each> 
          </xsl:variable>

          <xsl:choose>
                 <xsl:when test="string-length($ExtractedPatientID) &lt; 1">                  
                 <xsl:value-of select="/Hl7XmlMessage/PID/PID.3/PID.3.1"/>  
                 </xsl:when>
                 <xsl:when test="string-length($ExtractedPatientID) &gt; 0">
                 <xsl:value-of select="$ExtractedPatientID"/>    
                 </xsl:when>
           </xsl:choose> 
</xsl:template>


<xsl:template name="ExtractID_1">     
        <xsl:param name="IdPatient"/>
        <xsl:call-template name="ExtractID_2">
        <xsl:with-param name="IdPatient2">
        <xsl:value-of select="/Hl7XmlMessage/PID/PID.3/child::*[number($IdPatient)]/text()"/>  
        </xsl:with-param>   
        </xsl:call-template> 
 </xsl:template>

<xsl:template name="ExtractID_2">
       <xsl:param name="IdPatient2"/>
       <xsl:value-of select="substring-after($IdPatient2, '&#126;')"/>   
 </xsl:template>

</xsl:stylesheet>