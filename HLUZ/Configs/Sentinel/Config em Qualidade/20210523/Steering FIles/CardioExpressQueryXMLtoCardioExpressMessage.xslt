<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">
  <xsl:include href="CommonTemplates.xslt"/>

  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <root>
      <query>
        <ECGTitle/>
        <ExamStartDate/>
        <ExamEndDate/>
        <Modulity/>
        <ExamDepartment/>
        <PerformingPhysician/>
        <PatientName/>
        <PatientID/>
        <ExamID/>
        <RequestDepartment/>
      </query>
      <result>
        <Code>Success</Code>
        <Message>
          <xsl:variable name="noResults" select ="SentinelTests/CardioExpressSerializationMessage/Responses/CardioExpressSerializationMessageResponse"/>
          <xsl:value-of select="count($noResults)"/>
        </Message>
      </result>
      <records>
        <xsl:for-each select="SentinelTests/CardioExpressSerializationMessage/Responses/CardioExpressSerializationMessageResponse">
          <result>
            <SerialNO>
              <xsl:value-of select="RequestID"/>
            </SerialNO>
            <PatientID>
              <xsl:value-of select="PatientID"/>
            </PatientID>
            <PatientName>
              <xsl:value-of select="FamilyName"/>,<xsl:value-of select="GivenName"/>
            </PatientName>
            <PatientSex>
              <xsl:value-of select="Gender" />
            </PatientSex>
            <PatientAge>
              <xsl:value-of select ="PatientAge"/>
            </PatientAge>
            <PatientAgeUnit></PatientAgeUnit>
            <PatientBirthDate>
              <xsl:value-of select="PatientBirthDate"/>
            </PatientBirthDate>
            <Height>
              <xsl:value-of select="Height"/>
            </Height>
            <HeightUnit>cm</HeightUnit>
            <Weight>
              <xsl:value-of select="Weight"/>
            </Weight>
            <WeightUnit>kg</WeightUnit>
            <DiastolicBP></DiastolicBP>
            <SystolicBP></SystolicBP>
            <BPUnit>mmHg</BPUnit>
            <ExamDepartment></ExamDepartment>
            <RequestDepartment> <!-- [LMM - Coluna "Departamento" no electrocardiografo] -->
             <!--  <xsl:value-of select="BedNo"/>  --><!-- [LMM - Alteração para acomodar dados em PID.3.4] -->
              <xsl:value-of select="RequestDepartment"/>
            </RequestDepartment>
            <RequestDate>
              <xsl:value-of select="RequestDate"/>
            </RequestDate>
            <RequestID>
              <xsl:value-of select="RequestID"/>
            </RequestID>
            <RequestState>
              <xsl:value-of select="State"/>
            </RequestState>
            <Priority>
              <xsl:value-of select="Priority"/>
            </Priority>
            <ExamItem></ExamItem>
            <DoctorAdvice>
              <xsl:value-of select="Comments"/>
            </DoctorAdvice>
            <WardNo><!--  [LMM - Filtro basea-se neste dado] -->
             <!-- <xsl:value-of select="BedNo"/> --> <!-- [LMM - Alteração para acomodar dados em PID.3.4] -->
              <xsl:value-of select="RequestDepartment"/>
            </WardNo>
            <SickBedNo>
              <xsl:value-of select="BedNo"/>
            </SickBedNo>
            <Pacemaker>
              <xsl:value-of select="Pacemaker" />
            </Pacemaker>
            <Race>
              <xsl:value-of select="Race"/>
            </Race>
            <DrugsTaken>
              <xsl:value-of select="Medications"/>
            </DrugsTaken>
            <CustomName1>
              <xsl:value-of select="CustomField1Name"/>
            </CustomName1>
            <CustomContent1>
              <xsl:value-of select="CustomField1Value"/>
            </CustomContent1>
            <CustomName2>
              <xsl:value-of select="CustomField2Name"/>
            </CustomName2>
            <CustomContent2>
              <xsl:value-of select="CustomField2Value"/>
            </CustomContent2>
          </result>
        </xsl:for-each>
      </records>
    </root>
  </xsl:template>
</xsl:stylesheet>