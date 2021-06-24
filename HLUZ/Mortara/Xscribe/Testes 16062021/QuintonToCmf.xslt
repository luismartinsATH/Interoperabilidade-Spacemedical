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
         <Organisation>
            <xsl:call-template name="FunctionExtraiOrganizacao"> <!-- [LMM] Função para determinar organização do paciente -->
             <xsl:with-param name ="Organisation" select="StressTest/TestSummary/Institution/Value"/> 
            </xsl:call-template>
          </Organisation>
          <PatientNumber>
            <xsl:value-of select="StressTest/PatientDemographics/ID/Value"/>
          </PatientNumber>
          <PatientNumber2>
           <!--  <xsl:value-of select="StressTest/PatientDemographics/SecondaryID/Value"/> -->
          </PatientNumber2>
        </PatientID>
        <GivenName>
          <xsl:value-of select="StressTest/PatientDemographics/FirstName/Value"/>
         <!--  <xsl:value-of select="substring-after(/Q-Stress_Final_Report/Summary/EvIDPatientFullName, ',')"/> -->
        </GivenName>
        <FamilyName>
          <xsl:value-of select="StressTest/PatientDemographics/LastName/Value"/>
          <!-- <xsl:value-of select="substring-before(/Q-Stress_Final_Report/Summary/EvIDPatientFullName, ',')"/> -->
        </FamilyName>
        <MaidenName></MaidenName>
        <MiddleInitials></MiddleInitials>
        <DateOfBirth>
          <xsl:value-of select="StressTest/PatientDemographics/DobEx/Value"/>
          <!-- <xsl:call-template name="QuintonDobToXml">
            <xsl:with-param name="dob" select="/StressTest/PatientDemographics/DOB/Value"/>
          </xsl:call-template> -->
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
          <Facility>
             <xsl:value-of select="StressTest/TestSummary/Institution/Value"/>          
          </Facility>
        </Location>
      </Patient>
      <Test>
        <StartDateTime>
          <xsl:call-template name="FunctionincluiEspaco"> <!-- [LMM] Função para juntar data e hora numa string -->
            <xsl:with-param name ="data" select="StressTest/TestSummary/ExamDateEx/Value"/>
            <xsl:with-param name ="hora" select="StressTest/TestSummary/ExamTime/Value"/>
          </xsl:call-template>
          <!-- <xsl:value-of select="StressTest/TestSummary/ExamDate/Value"/><xsl:value-of select="StressTest/TestSummary/ExamTime/Value"/> -->
        </StartDateTime>
        <RecordingDuration><!-- <xsl:value-of select="StressTest/TestSummary/ExerciseTime/Value"/> --></RecordingDuration>
        <RecorderModel>Mortara X-Scribe</RecorderModel>
        <RecorderSerialNumber></RecorderSerialNumber>
        <TestStatus></TestStatus>
        <Height></Height>
        <Weight></Weight>
        <TestCreatedDateTime></TestCreatedDateTime>
        <Priority></Priority>
        <DownloadFacility><xsl:value-of select="StressTest/TestSummary/Institution/Value"/></DownloadFacility>
        <UserDefinedField1Value></UserDefinedField1Value>
        <UserDefinedField2Value></UserDefinedField2Value>
        <UserDefinedField3Value></UserDefinedField3Value>
        <UserDefinedField4Value></UserDefinedField4Value>
      </Test>
      <Order>
        <PlacerNumber>
			<xsl:value-of select="StressTest/PatientDemographics/OrderNumber/Value"/>
        </PlacerNumber>
      </Order>	  
      <Reports>
        <Report>
          <TestType>Esforço</TestType>
          <RecordingDuration><!-- <xsl:value-of select="StressTest/TestSummary/ExerciseTime/Value"/> --></RecordingDuration>
          <RecordingDateTime><xsl:value-of select="StressTest/TestSummary/ExamDateEx/Value"/></RecordingDateTime>
          <ReportFormat></ReportFormat>
          <ReportType>Esforço</ReportType>
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
      <xsl:with-param name="delimiter" select="string('-')"/>
      <xsl:with-param name="requiredIndex" select="2"/>
      <xsl:with-param name="currentIndex" select="0"/>
    </xsl:call-template>-<xsl:call-template name="SelectToken">
    <xsl:with-param name="text" select="$dob"/>
    <xsl:with-param name="delimiter" select="string('-')"/>
    <xsl:with-param name="requiredIndex" select="0"/>
    <xsl:with-param name="currentIndex" select="0"/>
    </xsl:call-template>-<xsl:call-template name="SelectToken">
      <xsl:with-param name="text" select="$dob"/>
      <xsl:with-param name="delimiter" select="string('-')"/>
      <xsl:with-param name="requiredIndex" select="1"/>
      <xsl:with-param name="currentIndex" select="0"/>
     </xsl:call-template>
  </xsl:template>

  <xsl:template name="FunctionExtraiOrganizacao"> <!-- [LMM] Função para determinar organização do paciente -->
    <xsl:param name="Organisation"/>
    <xsl:choose>
      <xsl:when test="contains($Organisation, 'Hospital da Luz')">HLUZ</xsl:when>
     <!-- <xsl:otherwise><xsl:value-of select="$org"/></xsl:otherwise> -->
    </xsl:choose>
  </xsl:template>

  <xsl:template name="FunctionincluiEspaco">
    <xsl:param name="data"/>
    <xsl:param name="hora"/>
    <xsl:value-of select="concat($data, ' ', $hora)"/>
  </xsl:template>

</xsl:stylesheet>