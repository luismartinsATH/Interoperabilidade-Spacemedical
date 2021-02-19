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
       
      <CardioServer>
        <MessageDateTime><xsl:value-of select="$now"/></MessageDateTime>
        <Patient>
          <Organisation><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:Organisation"/></Organisation>
          <ID><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:PatientNumber"/></ID>
          <ID2><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:PatientNumber2"/></ID2>
          <ID3><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:PatientNumber3"/></ID3>
          <NationalId><xsl:value-of select="cmf:Message/cmf:Patient/cmf:PatientID/cmf:NationalId"/></NationalId>
          <InsuranceNumber><xsl:value-of select="cmf:Message/cmf:Patient/cmf:InsuranceNumber"/></InsuranceNumber>
          <LastName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:FamilyName"/></LastName>
          <FirstName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:GivenName"/></FirstName>
          <MiddleInitials><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:MiddleInitials"/></MiddleInitials>
          <MaidenName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:MaidenName"/></MaidenName>
          <DateOfBirth><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:DateOfBirth"/></DateOfBirth>
          <Deceased><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Deceased"/></Deceased>
          <Sex><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Gender"/></Sex>
          <Weight>
            <Metric>
              <Kilogrammes>
                <xsl:call-template name ="ConvertGramsToKilos">
                  <xsl:with-param name="grams" select="/cmf:Message/cmf:Test/cmf:Weight"/>
                </xsl:call-template>
              </Kilogrammes>
              <Grammes>
                <xsl:call-template name="ConvertGramsToModuloKilos">
                  <xsl:with-param name="grams" select="/cmf:Message/cmf:Test/cmf:Weight"/>
                </xsl:call-template>
              </Grammes>
            </Metric>
            <Imperial>
              <Pounds>
                <xsl:call-template name="ConvertGramsToPounds">
                  <xsl:with-param name="grams" select="/cmf:Message/cmf:Test/cmf:Weight"/>
                </xsl:call-template>
              </Pounds>
              <Ounces>
                <xsl:call-template name="ConvertGramsToOunces">
                  <xsl:with-param name="grams" select="/cmf:Message/cmf:Test/cmf:Weight"/>
                </xsl:call-template>
              </Ounces>
            </Imperial>
          </Weight>
          <Height>
            <Metric>
              <Metres>
                <xsl:call-template name="GetWholeMetres">
                  <xsl:with-param name="metres" select="/cmf:Message/cmf:Test/cmf:Height"/>
                </xsl:call-template>
              </Metres>
              <Centimetres>
                <xsl:call-template name="ConvertMetresToCentimetres">
                  <xsl:with-param name="metres" select="/cmf:Message/cmf:Test/cmf:Height"/>
                </xsl:call-template>
              </Centimetres>
            </Metric>
            <Imperial>
              <Feet>
                <xsl:call-template name="ConvertMetresToFeet">
                  <xsl:with-param name="metres" select="/cmf:Message/cmf:Test/cmf:Height"/>
                </xsl:call-template>
              </Feet>
              <Inches>
                <xsl:call-template name="ConvertMetresToInches">
                  <xsl:with-param name="metres" select="/cmf:Message/cmf:Test/cmf:Height"/>
                </xsl:call-template>
              </Inches>
            </Imperial>
          </Height>
          <Pacemaker><xsl:value-of select="/cmf:Message/cmf:Test/cmf:Pacemaker"/></Pacemaker>
          <AddressLine1><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:AddressLine1"/></AddressLine1>
          <AddressLine2><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:AddressLine2"/></AddressLine2>
          <City><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:City"/></City>
          <StateorProvince><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:CountyRegion"/></StateorProvince>
          <ZipCode><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:PostZipcode"/></ZipCode>
          <Country><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:Country"/></Country>
          <HomePhone><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:HomePhone"/></HomePhone>
          <BusinessPhone><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:WorkPhone"/></BusinessPhone>
          <MobilePhone><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:MobilePhone"/></MobilePhone>
          <Email><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:Email"/></Email>
          <Ethnicity><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Ethnicity"/></Ethnicity>
          <Admitted><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Admitted"/></Admitted>
          <Discharged><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Discharged"/></Discharged>
          <Notes><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Notes"/></Notes>
          <UserDefinedField1><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:UserDefinedField1Value"/></UserDefinedField1>
          <UserDefinedField2><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:UserDefinedField2Value"/></UserDefinedField2>
          <UserDefinedField3><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:UserDefinedField3Value"/></UserDefinedField3>
          <UserDefinedField4><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:UserDefinedField4Value"/></UserDefinedField4>
          <Location>
            <FacilityName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:Facility"/></FacilityName>
            <PointOfCare><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:PointOfCare"/></PointOfCare>
            <Ward><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:Ward"/></Ward>
            <Bed><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:Bed"/></Bed>
          </Location>
          <Medications>
            <xsl:for-each select="/cmf:Message/cmf:Test/cmf:Medications/cmf:Medication">
              <Medication>
                <Name><xsl:value-of select="cmf:Name"/></Name>
                <Dosage><xsl:value-of select="cmf:Dosage"/></Dosage>
                <Units><xsl:value-of select="cmf:Units"/></Units>
                <Route><xsl:value-of select="cmf:Route"/></Route>
                <Regime><xsl:value-of select="cmf:Regime"/></Regime>
              </Medication>
            </xsl:for-each>
          </Medications>
        </Patient>
        <NextOfKin>
          <LastName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:ContactFamilyName"/></LastName>
          <FirstName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:ContactGivenName"/></FirstName>
          <HomePhone><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:ContactHomePhone"/></HomePhone>
          <MobilePhone><xsl:value-of select ="/cmf:Message/cmf:Patient/cmf:ContactMobilePhone"/></MobilePhone>
          <RelationshipToPatient><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:ContactRelationship"/></RelationshipToPatient>
        </NextOfKin>
        <Visit>
          <Number><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:VisitNumber"/></Number>
          <DateOpened><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:DateOpened"/></DateOpened>
          <DateClosed><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:DateClosed"/></DateClosed>
          <Type><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:CaseType"/></Type>
        </Visit>
        <Test>
          <ID><xsl:value-of select="/cmf:Message/cmf:Test/cmf:ID"/></ID>
          <ID2><xsl:value-of select="/cmf:Message/cmf:Test/cmf:ID2"/></ID2>
          <ID3><xsl:value-of select="/cmf:Message/cmf:Test/cmf:ID3"/></ID3>
          <TestTypeName><xsl:value-of select="/cmf:Message/cmf:Test/cmf:SentinelTestTypeName"/></TestTypeName>
          <TestStatus><xsl:value-of select="/cmf:Message/cmf:Test/cmf:TestStatus"/></TestStatus>
          <RecordingStartDateTime><xsl:value-of select="/cmf:Message/cmf:Test/cmf:StartDateTime"/></RecordingStartDateTime>
          <RecorderModel><xsl:value-of select="/cmf:Message/cmf:Test/cmf:RecorderModel"/></RecorderModel>
          <RecorderSerialNumber><xsl:value-of select="/cmf:Message/cmf:Test/cmf:RecorderSerialNumber"/></RecorderSerialNumber>
          <RecordingDuration><xsl:value-of select="/cmf:Message/cmf:Test/cmf:RecordingDuration"/></RecordingDuration>
          <Priority><xsl:value-of select="/cmf:Message/cmf:Test/cmf:Priority"/></Priority>
          <UserDefinedField1><xsl:value-of select="/cmf:Message/cmf:Test/cmf:UserDefinedField1Value"/></UserDefinedField1>
          <UserDefinedField2><xsl:value-of select="/cmf:Message/cmf:Test/cmf:UserDefinedField2Value"/></UserDefinedField2>
          <UserDefinedField3><xsl:value-of select="/cmf:Message/cmf:Test/cmf:UserDefinedField3Value"/></UserDefinedField3>
          <UserDefinedField4><xsl:value-of select="/cmf:Message/cmf:Test/cmf:UserDefinedField4Value"/></UserDefinedField4>
          <Comments><xsl:value-of select="/cmf:Message/cmf:Test/cmf:Comments"/></Comments>
          <Consultant>
            <ID><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:StaffNumber"/></ID>
            <Name><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:Name"/></Name>
            <LastName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:FamilyName"/></LastName>
            <FirstName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:GivenName"/></FirstName>
            <Title><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:Title"/></Title>
          </Consultant>
          <ReferringPhysician>
            <ID><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:StaffNumber"/></ID>
            <Name><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:Name"/></Name>
            <LastName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:FamilyName"/></LastName>
            <FirstName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:GivenName"/></FirstName>
            <Title><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:Title"/></Title>
          </ReferringPhysician>
          <HookupTechnician>
            <ID><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:HookupTechnician/cmf:StaffNumber"/></ID>
            <Name><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:HookupTechnician/cmf:Name"/></Name>
            <LastName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:HookupTechnician/cmf:FamilyName"/></LastName>
            <FirstName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:HookupTechnician/cmf:GivenName"/></FirstName>
            <Title><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:HookupTechnician/cmf:Title"/></Title>
          </HookupTechnician>
          <AnalysisTechnician>
            <ID><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:AnalysisTechnician/cmf:StaffNumber"/></ID>
            <Name><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:AnalysisTechnician/cmf:Name"/></Name>
            <LastName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:AnalysisTechnician/cmf:FamilyName"/></LastName>
            <FirstName><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:AnalysisTechnician/cmf:GivenName"/></FirstName>
            <Title><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:AnalysisTechnician/cmf:Title"/></Title>
          </AnalysisTechnician>
          <Indications>
            <xsl:for-each select="/cmf:Message/cmf:Test/cmf:Indications/cmf:Indication">
              <Indication>
                <Name><xsl:value-of select="cmf:Name"/></Name>
              </Indication>
            </xsl:for-each>
          </Indications>
        </Test>
        <Order>
          <PlacerNumber><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:PlacerNumber"/></PlacerNumber>
          <FillerNumber><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:FillerNumber"/></FillerNumber>
          <OrderPlacer><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:OrderPlacer"/></OrderPlacer>
          <RequestedDateTime><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:RequestedDateTime"/></RequestedDateTime>
          <OrderingPhysician><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:OrderingPhysician"/></OrderingPhysician>
        </Order>
        <Measurements>
          <xsl:for-each select="/cmf:Message/cmf:ArrayOfMeasurement/cmf:Measurement">
            <xsl:variable name="localName">
              <xsl:call-template name="replace">
                <xsl:with-param name="text" select="cmf:Name"/>
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
        </Measurements>
        <Report>
          <PathToPdfFile><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:ReportLink"/></PathToPdfFile>
          <Status><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Status"/></Status>
          <Comments><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Comments"/></Comments>
        </Report>
      </CardioServer>
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

  <!-- Calculates the whole number of pounds for a given number of grams, the remainder (in ounces) can be found by calling ConvertGramsToOunces -->
  <xsl:template name="ConvertGramsToPounds">
    <xsl:param name="grams"/>
    <xsl:if test="$grams > 0">
      <xsl:variable name="ounces" select="round($grams div 28.35)"/>
      <xsl:value-of select="floor($ounces div 16)"/>
    </xsl:if>
  </xsl:template>

  <!-- Calculates the remainder in ounces of the grams parameter. Call ConvertGramsToPounds to find the whole number of pounds. -->
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
