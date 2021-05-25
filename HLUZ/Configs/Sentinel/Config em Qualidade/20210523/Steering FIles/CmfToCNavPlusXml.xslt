<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:cmf="urn:dmr-cmf">
    <xsl:include href="CommonTemplates.xslt"/>
    <xsl:output method="xml" indent="yes"/>

  <!-- PARAMS: -->
  <!-- Control ID -->
  <xsl:param name="MessageID"/>
  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    
    <xsl:variable name="ReportPath">
      <xsl:call-template name="RenameImpresarioReportFile">
        <xsl:with-param name="CurrentName" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:ReportLink" xmlns:cmf="urn:dmr-cmf"/>
      </xsl:call-template>
    </xsl:variable>
    
      <IMPRESARIO_SUMMARY>
        <PID>
          <Patient_IDinternal><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:PatientNumber"/></Patient_IDinternal>
          <Patient_LastName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:FamilyName"/></Patient_LastName>
          <Patient_FirstName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:GivenName"/></Patient_FirstName>
          <Patient_MiddleName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:MiddleInitials"/></Patient_MiddleName>
          <Patient_DateOfBirth><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:DateOfBirth"/></Patient_DateOfBirth>
          <Patient_Sex>
            <xsl:call-template name="SentinelToImpresarioGender">
              <xsl:with-param name="SentinelGender" select="/cmf:Message/cmf:Patient/cmf:Gender"/>
            </xsl:call-template>
          </Patient_Sex>
          <Patient_WeightPounds>
            <xsl:call-template name="ConvertGramsToPounds">
              <xsl:with-param name="grams" select="/cmf:Message/cmf:Test/cmf:Weight"/>
            </xsl:call-template>
          </Patient_WeightPounds>
          <Patient_WeightOunces>
            <xsl:call-template name="ConvertGramsToOunces">
              <xsl:with-param name="grams" select="/cmf:Message/cmf:Test/cmf:Weight"/>
            </xsl:call-template>
          </Patient_WeightOunces>
          <Patient_WeightKilograms>
            <xsl:call-template name ="ConvertGramsToKilos">
              <xsl:with-param name="grams" select="/cmf:Message/cmf:Test/cmf:Weight"/>
            </xsl:call-template>
          </Patient_WeightKilograms>
          <Patient_WeightGrams>
            <xsl:call-template name="ConvertGramsToModuloKilos">
              <xsl:with-param name="grams" select="/cmf:Message/cmf:Test/cmf:Weight"/>
            </xsl:call-template>
          </Patient_WeightGrams>
          <Patient_HeightFeet>
            <xsl:call-template name="ConvertMetresToFeet">
              <xsl:with-param name="metres" select="/cmf:Message/cmf:Test/cmf:Height"/>
            </xsl:call-template>
          </Patient_HeightFeet>
          <Patient_HeightInches>
            <xsl:call-template name="ConvertMetresToInches">
              <xsl:with-param name="metres" select="/cmf:Message/cmf:Test/cmf:Height"/>
            </xsl:call-template>
          </Patient_HeightInches>
          <Patient_HeightMeters>
            <xsl:call-template name="GetWholeMetres">
              <xsl:with-param name="metres" select="/cmf:Message/cmf:Test/cmf:Height"/>
            </xsl:call-template>
          </Patient_HeightMeters>
          <Patient_HeightCentimeters>
            <xsl:call-template name="ConvertMetresToCentimetres">
              <xsl:with-param name="metres" select="/cmf:Message/cmf:Test/cmf:Height"/>
            </xsl:call-template>
          </Patient_HeightCentimeters>
          <Patient_StreetAddress1><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:AddressLine1"/></Patient_StreetAddress1>
          <Patient_StreetAddress2><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:AddressLine2"/></Patient_StreetAddress2>
          <Patient_City><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:City"/></Patient_City>
          <Patient_StateorProvince><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:CountyRegion"/></Patient_StateorProvince>
          <Patient_ZipCode><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:PostZipcode"/></Patient_ZipCode>
          <Patient_Country><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:Country"/></Patient_Country>
          <Patient_SocialSecurityNumber><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:PatientNumber2"/></Patient_SocialSecurityNumber>
          <Patient_HomePhone><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:HomePhone"/></Patient_HomePhone>
          <Patient_BusinessPhone><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:WorkPhone"/></Patient_BusinessPhone>
          <Patient_MobilePhone><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:MobilePhone"/></Patient_MobilePhone>
          <Patient_Email><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:Email"/></Patient_Email>
        </PID>
        <NK1>
          <NextofKin_Name>
            <xsl:value-of select="concat(/cmf:Message/cmf:Patient/cmf:ContactGivenName, ' ')"/>   <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:ContactFamilyName"/>
          </NextofKin_Name>
          <NextofKin_Relationship><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:ContactRelationship"/></NextofKin_Relationship>
          <NextofKin_Phone><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:ContactHomePhone"/></NextofKin_Phone>
          <NextofKin_MobilePhone><xsl:value-of select ="/cmf:Message/cmf:Patient/cmf:ContactMobilePhone"/></NextofKin_MobilePhone>
        </NK1>
        <PV1>
          <AttendingPhysician_ID><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:StaffNumber"/></AttendingPhysician_ID>
          <AttendingPhysician_LastName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:FamilyName"/></AttendingPhysician_LastName>
          <AttendingPhysician_FirstName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:GivenName"/></AttendingPhysician_FirstName>
          <AttendingPhysician_MiddleName></AttendingPhysician_MiddleName>
          <AttendingPhysician_Title><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:Title"/></AttendingPhysician_Title>
          <AttendingPhysician_Street1></AttendingPhysician_Street1>
          <AttendingPhysician_Street2></AttendingPhysician_Street2>
          <AttendingPhysician_City></AttendingPhysician_City>
          <AttendingPhysician_StateorProvince></AttendingPhysician_StateorProvince>
          <AttendingPhysician_ZipCode></AttendingPhysician_ZipCode>
          <AttendingPhysician_Country></AttendingPhysician_Country>
          <AttendingPhysician_WorkPhone></AttendingPhysician_WorkPhone>
          <AttendingPhysician_Fax></AttendingPhysician_Fax>
          <AttendingPhysician_MobilePhone></AttendingPhysician_MobilePhone>
          <AttendingPhysician_Email></AttendingPhysician_Email>
          <HookupTechnician_ID><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:HookupTechnician/cmf:StaffNumber"/></HookupTechnician_ID>
          <HookupTechnician_LastName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:HookupTechnician/cmf:FamilyName"/></HookupTechnician_LastName>
          <HookupTechnician_FirstName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:HookupTechnician/cmf:GivenName"/></HookupTechnician_FirstName>
          <HookupTechnician_MiddleName></HookupTechnician_MiddleName>
          <HookupTechnician_Employer></HookupTechnician_Employer>
          <HookupTechnician_Street1></HookupTechnician_Street1>
          <HookupTechnician_Street2></HookupTechnician_Street2>
          <HookupTechnician_City></HookupTechnician_City>
          <HookupTechnician_StateorProvince></HookupTechnician_StateorProvince>
          <HookupTechnician_ZipCode></HookupTechnician_ZipCode>
          <HookupTechnician_Country></HookupTechnician_Country>
          <HookupTechnician_WorkPhone></HookupTechnician_WorkPhone>
          <HookupTechnician_Fax></HookupTechnician_Fax>
          <HookupTechnician_MobilePhone></HookupTechnician_MobilePhone>
          <HookupTechnician_HomePhone></HookupTechnician_HomePhone>
          <HookupTechnician_Email></HookupTechnician_Email>
        </PV1>
        <Facility>
          <Facility_FacilityName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:Facility"/></Facility_FacilityName>
          <Facility_Street1></Facility_Street1>
          <Facility_Street2></Facility_Street2>
          <Facility_City></Facility_City>
          <Facility_StateorProvince></Facility_StateorProvince>
          <Facility_ZipCode></Facility_ZipCode>
          <Facility_Country></Facility_Country>
          <Facility_Phone></Facility_Phone>
          <Facility_Fax></Facility_Fax>
          <Facility_Email></Facility_Email>
          <Facility_ContactName>, </Facility_ContactName>
          <Facility_ContactPhone></Facility_ContactPhone>
          <Facility_ContactEmail></Facility_ContactEmail>
        </Facility>
        <MEASUREMENTS>
          <xsl:for-each select="/cmf:Message/cmf:ArrayOfMeasurement/cmf:Measurement">
            <xsl:variable name="localName">
              <xsl:call-template name="replace">
                <xsl:with-param name="text" select="cmf:Name/text()"/>
                <xsl:with-param name="replace" select="' '"/>
                <xsl:with-param name="by" select="''"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="localName2">
              <xsl:call-template name="replace">
                <xsl:with-param name="text" select="$localName"/>
                <xsl:with-param name="replace" select="'/'"/>
                <xsl:with-param name="by" select="''"/>
              </xsl:call-template>
            </xsl:variable>
            <xsl:element name="{$localName2}">
              <xsl:value-of select="cmf:Value"/>
            </xsl:element>
          </xsl:for-each>
        </MEASUREMENTS>
        <ReportPath>
          <xsl:value-of select="$ReportPath"/>
        </ReportPath>
        <XmlPath>
          <xsl:call-template name="replace">
            <xsl:with-param name="text" select="$ReportPath"/>
            <xsl:with-param name="replace" select="'.pdf'"/>
            <xsl:with-param name="by" select="'.xml'"/>
          </xsl:call-template>
        </XmlPath>
      </IMPRESARIO_SUMMARY>
    </xsl:template>

  <xsl:template name="RenameImpresarioReportFile">
    <xsl:param name="CurrentName"/>
    <xsl:variable name="reportID" select="/cmf:Message/ArrayOfMeasurement/Measurement/Name[text()='Report ID']/../Value/text()"/>
    <xsl:value-of select="utils:RenamePdf($CurrentName, '{0}.pdf', $reportID)" xmlns:utils="urn:CodeUtils"/>
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

  <xsl:template name="SentinelToImpresarioGender">
    <xsl:param name="SentinelGender"/>
    <xsl:choose>
      <xsl:when test="$SentinelGender='Female'">0</xsl:when>
      <xsl:when test="$SentinelGender='Male'">1</xsl:when>
      <xsl:when test="$SentinelGender='Unknown'">2</xsl:when>
    </xsl:choose>
  </xsl:template>

  <!-- Calculate whole number of kilos from the inputted grams -->
  <xsl:template name="ConvertGramsToKilos">
    <xsl:param name="grams"/>
    <xsl:if test="$grams > 0">
      <xsl:value-of select="floor($grams div 1000)"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="ConvertGramsToModuloKilos">
    <xsl:param name="grams"/>
    <xsl:if test="$grams > 0">
      <xsl:value-of select="$grams mod 1000"/>
    </xsl:if>
  </xsl:template>

  <!-- Calculates the whole number of pounds
  for a given number of grams, the remainder (in ounces)
  can be found by calling ConvertGramsToOunces -->
  <xsl:template name="ConvertGramsToPounds">
    <xsl:param name="grams"/>
    <xsl:if test="$grams > 0">
      <xsl:variable name="ounces" select="round($grams div 28.35)"/>
      <xsl:value-of select="floor($ounces div 16)"/>
    </xsl:if>
  </xsl:template>

  <!-- Calculates the remainder in ounces of the grams parameter.
  Call ConvertGramsToPounds to find the whole number of pounds. -->
  <xsl:template name="ConvertGramsToOunces">
    <xsl:param name="grams"/>
    <xsl:if test="$grams > 0">
      <xsl:variable name="ounces" select="round($grams div 28.35)"/>
      <xsl:value-of select="$ounces mod 16"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="GetWholeMetres">
    <xsl:param name="metres"/>
    <xsl:if test="$metres > 0">
      <xsl:value-of select="floor($metres)"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="ConvertMetresToCentimetres">
    <xsl:param name="metres"/>
    <xsl:if test="$metres > 0">
      <xsl:value-of select="($metres mod 1) * 100"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="ConvertMetresToFeet">
    <xsl:param name="metres"/>
    <xsl:if test="$metres > 0">
      <xsl:variable name="totalInches" select="round(($metres * 100) div 2.54)"/>
      <xsl:value-of select="floor($totalInches div 12)"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="ConvertMetresToInches">
    <xsl:param name="metres"/>
    <xsl:if test="$metres > 0">
      <xsl:variable name="totalInches" select="round(($metres * 100) div 2.54)"/>
      <xsl:value-of select="$totalInches mod 12"/>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>
