<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
                xmlns:cmf="urn:dmr-cmf"
                xmlns:sci="http://www.show.scot.nhs.uk/isd/SCIStore"
                xmlns:gen="http://www.show.scot.nhs.uk/isd/General">
  
  <xsl:output method="xml" indent="yes"/>

  <xsl:param name="MessageID"/>
  <xsl:param name="now"/>
  
  <xsl:template match="/">

    <xsl:variable name="CurrentName" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:ReportLink" xmlns:cmf="urn:dmr-cmf"/>
    <xsl:variable name="ReportId"  select="/cmf:Message/cmf:Reports/cmf:Report/cmf:ID"/>
    <xsl:variable name="ReportPath">
      <xsl:value-of select="utils:RenamePdf($CurrentName, '{0}.pdf', $ReportId)" xmlns:utils="urn:CodeUtils"/>
    </xsl:variable>
    
    <DocumentUpload xmlns="http://www.show.scot.nhs.uk/isd/DocumentUpload" xmlns:gen="http://www.show.scot.nhs.uk/isd/General" xmlns:sci="http://www.show.scot.nhs.uk/isd/SCIStore" xmlns:h="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.show.scot.nhs.uk/isd/DocumentUpload C:\SCISTO~1\SourceCode.PVCS\StoreWSMetadata\Store23\DocumentUpload-V2-3.xsd">
      <sci:MessageData>
        <sci:PatientDemographics>
          <gen:PatientId>
            <gen:IdValue>
              <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:PatientNumber"/>
            </gen:IdValue>
            <gen:IdScheme>CHI</gen:IdScheme>
            <gen:IdType>PERSONAL</gen:IdType>
          </gen:PatientId>
          <gen:PatientName>
            <gen:StructuredName>
              <gen:GivenName>
                <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:GivenName"/>
              </gen:GivenName>
              <gen:FamilyName>
                <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:FamilyName"/>
              </gen:FamilyName>
            </gen:StructuredName>
          </gen:PatientName>
          <gen:PatientAddress>
            <gen:StructuredAddress>
              <gen:AddressLine>
                <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:AddressLine1"/>
              </gen:AddressLine>
              <gen:AddressLine>
                <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:AddressLine2"/>
              </gen:AddressLine>
              <gen:AddressLine>
                <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:City"/>
              </gen:AddressLine>
            </gen:StructuredAddress>
            <gen:PostCode>
              <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:PostZipcode"/>
            </gen:PostCode>
            <gen:AddressType>Current</gen:AddressType>
          </gen:PatientAddress>
          <gen:DateOfBirth>
            <xsl:call-template name="ExtractDateFromDateTime">
              <xsl:with-param name="dateTime" select="/cmf:Message/cmf:Patient/cmf:DateOfBirth"/>
            </xsl:call-template>
          </gen:DateOfBirth>
          <gen:Sex>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Gender"/>
          </gen:Sex>
        </sci:PatientDemographics>
        <sci:ClinicalData>
          <sci:DocumentSubCategory>Cardiac</sci:DocumentSubCategory>
          <sci:DocumentSpecialty>Cardiology</sci:DocumentSpecialty>
          <sci:DocumentTitle>
            <xsl:call-template name="FunctionSentinelTestTypeToText">
              <xsl:with-param name="procedure" select="/cmf:Message/cmf:Test/cmf:TestTypeName"/>
            </xsl:call-template> Report
          </sci:DocumentTitle>
          <sci:DocumentOrganisationName>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:Facility"/>
          </sci:DocumentOrganisationName>
          <sci:DocumentOrganisationType>Hospital</sci:DocumentOrganisationType>
          <!-- Used to carry an error message if the PDF file is found to exceed the maximum file size allowed by SCI Store. 
          The error message is inserted by the Sentinel SCI Store Service. -->
          <sci:AdditionalText>(No additional text)</sci:AdditionalText>
        </sci:ClinicalData>
      </sci:MessageData>
      <sci:DocumentData>
        <gen:DocumentCategory>Reports</gen:DocumentCategory>
        <gen:DocumentIdentifier>
          <!-- PDF filename is set by the Sentinel SCI Store Service -->
          <gen:IdValue></gen:IdValue>
          <gen:IdScheme>ClinicalDocument</gen:IdScheme>
          <gen:IdType>Document</gen:IdType>
        </gen:DocumentIdentifier>
        <!-- Document revision number is set by the Sentinel SCI Store Service -->
        <gen:DocumentRevision></gen:DocumentRevision>
        <!-- Document status is set by the Sentinel SCI Store Service -->
        <gen:DocumentStatus></gen:DocumentStatus>
        <!-- Educated Guess: Sentinel's 'responsible' physician used to populate the Originating HCP. -->
        <gen:OriginatingHcp>
          <gen:HcpId>
            <gen:IdValue>NOT CODED</gen:IdValue>
            <gen:IdScheme>GMC</gen:IdScheme>
            <gen:IdType>PERSON</gen:IdType>
          </gen:HcpId>
          <gen:HcpName>
            <gen:StructuredName>
              <gen:GivenName>
                <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:GivenName"/>
              </gen:GivenName>
              <gen:FamilyName>
                <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:FamilyName"/>
              </gen:FamilyName>
            </gen:StructuredName>
          </gen:HcpName>
        </gen:OriginatingHcp>
        <!-- Educated Guess: Signer of the report used for the Attesting HCP. -->
        <gen:Attesting_Hcp>
          <gen:HcpId>
            <gen:IdValue>NOT CODED</gen:IdValue>
            <gen:IdScheme>GMC</gen:IdScheme>
            <gen:IdType>PERSON</gen:IdType>
          </gen:HcpId>
          <gen:HcpName>
            <gen:UnstructuredName>
              <xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Interpreter"/>
            </gen:UnstructuredName>
          </gen:HcpName>
        </gen:Attesting_Hcp>
        <!-- PDFs are sent to SCI Store as soon as they are confirmed in Sentinel so the current time
        is also the time at which the report being sent was confirmed. -->
        <gen:DocumentAttestationDate>
          <xsl:call-template name="ConvertNowValueToDate">
            <xsl:with-param name="now" select="$now"/>
          </xsl:call-template>
        </gen:DocumentAttestationDate>
        <gen:DocumentAttestationTime>
          <xsl:call-template name="ConvertNowValueToTime">
            <xsl:with-param name="now" select="$now"/>
          </xsl:call-template>
        </gen:DocumentAttestationTime>
        <!-- Don't have a value for ReceivingHcp.  Could conceivably be ordering phyisican but GGC don't use orders. -->
        <gen:ReceivingHcp>
          <gen:HcpId>
            <gen:IdValue>NOT CODED</gen:IdValue>
            <gen:IdScheme>GMC</gen:IdScheme>
            <gen:IdType>PERSON</gen:IdType>
          </gen:HcpId>
          <gen:HcpName>
            <gen:StructuredName>
              <gen:GivenName>(unspecified)</gen:GivenName>
              <gen:FamilyName>(unspecified)</gen:FamilyName>
            </gen:StructuredName>
          </gen:HcpName>
        </gen:ReceivingHcp>
        <gen:PatientConsent>Y</gen:PatientConsent>
        <gen:Sensitivity>S</gen:Sensitivity>
      </sci:DocumentData>
      <XmlPath xmlns="">
        <xsl:call-template name="replace">
          <xsl:with-param name="text" select="$ReportPath"/>
          <xsl:with-param name="replace" select="'.pdf'"/>
          <xsl:with-param name="by" select="'.xml'"/>
        </xsl:call-template>
      </XmlPath>
      <ReportId><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:ID"/></ReportId>
      <ReportComments><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Comments"/></ReportComments>
    </DocumentUpload>
  </xsl:template>

  <!-- Example Input: 2010-10-27T15:39:57 Output: 2010-10-27 -->
  <xsl:template name="ExtractDateFromDateTime">
    <xsl:param name="dateTime"/>
    <xsl:value-of select="substring($dateTime, 1, 10)"/>
  </xsl:template>

  <!-- Example Input: 2010-10-27T15:39:57 Output: 15:39:57  -->
  <xsl:template name="ExtractTimeFromDateTime">
    <xsl:param name="dateTime"/>
    <xsl:value-of select="substring($dateTime, 12, 8)"/>
  </xsl:template>

  <!-- Converts the Now time stamp passed into steering files to an XSD date: 201105061510 to 2011-05-06 -->
  <xsl:template name="ConvertNowValueToDate">
    <xsl:param name="now"/>
    <xsl:variable name="year" select="substring($now, 1, 4)"/>
    <xsl:variable name="month" select="substring($now, 5, 2)"/>
    <xsl:variable name="day" select="substring($now, 7, 2)"/>
    <xsl:value-of select="concat($year, '-', $month, '-', $day)"/>
  </xsl:template>

  <!-- Converts the Now time stamp passed into steering files to an XSD time: 201105061510 to 2011-05-06 -->
  <xsl:template name="ConvertNowValueToTime">
    <xsl:param name="now"/>
    <xsl:variable name="hours" select="substring($now, 9, 2)"/>
    <xsl:variable name="minutes" select="substring($now, 11, 2)"/>
    <xsl:variable name="seconds" select="substring($now, 13, 2)"/>
    <xsl:value-of select="concat($hours, ':', $minutes, ':', $seconds, '.0')"/>
  </xsl:template>

  <!-- Converts the test type GUID to the Sci-Store test type name -->
  <xsl:template name="FunctionSentinelTestTypeToText">
    <xsl:param name="procedure"/>
    <xsl:choose>
      <xsl:when test="starts-with($procedure, '18754-2^LN')">Ambulatory ECG</xsl:when>
      <xsl:when test="starts-with($procedure, 'Blood Pressure^00')">Ambulatory Blood Pressure</xsl:when>
      <xsl:when test="starts-with($procedure, '18752-6^LN')">Exercise Tolerance Test</xsl:when>
      <xsl:when test="starts-with($procedure, '11524-0^LN')">Resting ECG</xsl:when>
      <xsl:when test="starts-with($procedure, 'Rhythm^00')">Rhythm ECG</xsl:when>
      <xsl:when test="starts-with($procedure, 'Ergospirometry^00')">Ergospirometry</xsl:when>
      <xsl:when test="starts-with($procedure, 'Event^00')">Event ECG</xsl:when>
      <xsl:when test="starts-with($procedure, 'Spirometry^00')">Spirometry</xsl:when>
      <xsl:when test="starts-with($procedure, 'Plethysmography^00')">Plethysmography</xsl:when>
      <xsl:otherwise><xsl:value-of select="$procedure"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="replace">
    <xsl:param name="text"/>
    <xsl:param name="replace"/>
    <xsl:param name="by"/>

    <xsl:choose>
      <xsl:when test="contains($text, $replace)">
        <xsl:value-of select="substring-before($text, $replace)"/>
        <xsl:value-of select="$by"/>
        <xsl:call-template name="replace">
          <xsl:with-param name="text" select="substring-after($text, $replace)"/>
          <xsl:with-param name="replace" select="$replace"/>
          <xsl:with-param name="by" select="$by"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>

