<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cmf="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">
  <xsl:include href="CommonTemplates.xslt"/>

  <!-- PARAMS: -->
  <!-- Control ID (unique numeric ID for a ORU message) -->
  <xsl:param name="MessageID"/>
  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <Hl7XmlMessage>
      <MSH>
        <MSH.1>|^~\&amp;</MSH.1>
        <MSH.2>Sentinel</MSH.2>
        <MSH.3>Cardiology</MSH.3>
        <MSH.4>SONHO</MSH.4>
        <MSH.5>HH</MSH.5>
        <MSH.6><xsl:value-of select="$now"/></MSH.6>
        <MSH.8>
          <MSH.8.1>ORU</MSH.8.1>
          <MSH.8.2>R01</MSH.8.2>
        </MSH.8>
        <MSH.9><xsl:value-of select="$MessageID"/></MSH.9>
        <MSH.10>P</MSH.10>
        <MSH.11>2.5</MSH.11>
      </MSH>
      <PID>
        <PID.3><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:PatientNumber"/></PID.3>
        <PID.5>
          <PID.5.1><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:FamilyName"/></PID.5.1>
          <PID.5.2><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:GivenName"/></PID.5.2>
          <PID.5.3><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:MiddleInitials"/></PID.5.3>
          <PID.5.5><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Title"/></PID.5.5>
        </PID.5>
        <PID.7>
          <xsl:call-template name="FunctionXmlToHl7Date">
            <xsl:with-param name="date" select="/cmf:Message/cmf:Patient/cmf:DateOfBirth"/>
          </xsl:call-template>
        </PID.7>
        <PID.8>
          <xsl:call-template name="FunctionSentinelToHl7GenderCode">
            <xsl:with-param name="gender" select="/cmf:Message/cmf:Patient/cmf:Gender"/>
          </xsl:call-template>
        </PID.8>
        <PID.10><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Ethnicity"/></PID.10>
        <PID.11>
          <PID.11.1><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:AddressLine1"/></PID.11.1>
          <PID.11.2><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:AddressLine2"/></PID.11.2>
          <PID.11.3><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:City"/></PID.11.3>
          <PID.11.4><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:CountyRegion"/></PID.11.4>
          <PID.11.5><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:PostZipcode"/></PID.11.5>
          <PID.11.6><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:Country"/></PID.11.6>
        </PID.11>
        <PID.13><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:HomePhone"/></PID.13>
        <PID.19><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:PatientNumber2"/></PID.19>
      </PID>
      <PV1>
        <PV1.2>
          <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Class"/>
        </PV1.2>
        <PV1.3>
          <PV1.3.1><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:PointOfCare"/></PV1.3.1>
          <PV1.3.2><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:Ward"/></PV1.3.2>
          <PV1.3.3><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:Bed"/></PV1.3.3>
          <PV1.3.4><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:Facility"/></PV1.3.4>
        </PV1.3>
        <xsl:if test="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:Verified = 'True'">
        <PV1.7>
          <PV1.7.1><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:StaffNumber"/></PV1.7.1>
          <PV1.7.2><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:FamilyName"/></PV1.7.2>
          <PV1.7.3><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:GivenName"/></PV1.7.3>
          <PV1.7.6><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:Title"/></PV1.7.6>
        </PV1.7>
        </xsl:if>
        <xsl:if test="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:Verified = 'True'">
        <PV1.8>
          <PV1.8.1><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:StaffNumber"/></PV1.8.1>
          <PV1.8.2><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:FamilyName"/></PV1.8.2>
          <PV1.8.3><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:GivenName"/></PV1.8.3>
          <PV1.8.6><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:Title"/></PV1.8.6>
        </PV1.8>
        </xsl:if>
        <PV1.19><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:VisitNumber"/></PV1.19>
        <PV1.44>
          <xsl:call-template name="FunctionXmlToHl7DateTime">
            <xsl:with-param name="dateTime" select="/cmf:Message/cmf:Patient/cmf:Admitted"/>
          </xsl:call-template>
        </PV1.44>
        <PV1.45>
          <xsl:call-template name="FunctionXmlToHl7DateTime">
            <xsl:with-param name="dateTime" select="/cmf:Message/cmf:Patient/cmf:Discharged"/>
          </xsl:call-template>
        </PV1.45>
      </PV1>
      <OBR>
        <OBR.1>1</OBR.1>
        <OBR.2><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:PlacerNumber"/></OBR.2>
        <OBR.3><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:FillerNumber"/></OBR.3>
        <OBR.4>
          <OBR.4.1>
            <xsl:call-template name="FunctionSentinelTestTypeToHl7">
              <xsl:with-param name="procedure" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:TestType"/>
              <xsl:with-param name="testTypeName" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:TestTypeName"/>
            </xsl:call-template>
          </OBR.4.1>
          <OBR.4.2>
            <xsl:call-template name="FunctionSentinelTestTypeToHl7CodeSet">
              <xsl:with-param name="procedure" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:TestType"/>
            </xsl:call-template>
          </OBR.4.2>
        </OBR.4>
        <OBR.7>
          <xsl:call-template name="FunctionXmlToHl7DateTime">
            <xsl:with-param name="dateTime" select="/cmf:Message/cmf:Test/cmf:StartDateTime"/>
          </xsl:call-template>
        </OBR.7>
        <OBR.16>
          <xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:OrderPlacer"/>
        </OBR.16>
        <OBR.25>
          <xsl:call-template name="FunctionCmfReportStatusToHl7">
            <xsl:with-param name="interpreter" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Interpreter/text()"></xsl:with-param>
          </xsl:call-template>
        </OBR.25>
      </OBR>
      <OBX>
        <OBX.1>1</OBX.1>
        <OBX.2>ED</OBX.2>
        <OBX.3>
          <OBX.3.1>
            <xsl:call-template name="FunctionSentinelTestTypeToHl7">
              <xsl:with-param name="procedure" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:TestType"/>
              <xsl:with-param name="testTypeName" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:TestTypeName"/>
            </xsl:call-template>
          </OBX.3.1>
          <OBX.3.2>
            <xsl:call-template name="FunctionSentinelTestTypeToHl7CodeSet">
              <xsl:with-param name="procedure" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:TestType"/>
            </xsl:call-template>
          </OBX.3.2>
        </OBX.3>
<!--        <OBX.5>
          <OBX.5.1>1.2.826.0.1.921452</OBX.5.1>
          <OBX.5.2>Application</OBX.5.2>
          <OBX.5.3>PDF</OBX.5.3>
          <OBX.5.4>Base64</OBX.5.4>
          <OBX.5.5><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:ReportData"/></OBX.5.5>
        </OBX.5>
-->
        <OBX.11>
          <xsl:call-template name="FunctionCmfReportStatusToHl7">
            <xsl:with-param name="interpreter" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Interpreter/text()"></xsl:with-param>
          </xsl:call-template>
        </OBX.11>
      </OBX>
      <OBX>
        <OBX.1>2</OBX.1>
        <OBX.2>RP</OBX.2>
<!--
        <OBX.3>
          <OBX.3.1>
            <xsl:call-template name="FunctionSentinelTestTypeToHl7">
              <xsl:with-param name="procedure" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:TestType"/>
            </xsl:call-template>
          </OBX.3.1>
          <OBX.3.2>
            <xsl:call-template name="FunctionSentinelTestTypeToHl7CodeSet">
              <xsl:with-param name="procedure" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:TestType"/>
            </xsl:call-template>
          </OBX.3.2>
        </OBX.3>
-->
        <OBX.5>
          <OBX.5.1>
            <xsl:call-template name="RenameReportFile">
              <xsl:with-param name="CurrentName"  select="/cmf:Message/cmf:Reports/cmf:Report/cmf:ReportLink"/>
            </xsl:call-template>
          </OBX.5.1>
          <OBX.5.3>AP</OBX.5.3>
          <OBX.5.4>PDF</OBX.5.4>
        </OBX.5>
 
        <OBX.11>
          <xsl:call-template name="FunctionCmfReportStatusToHl7">
            <xsl:with-param name="interpreter" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Interpreter/text()"></xsl:with-param>
          </xsl:call-template>
        </OBX.11>
      </OBX>
<!--	  
      <xsl:for-each select="/cmf:Message/ArrayOfMeasurement/Measurement">
        <OBX>
          <OBX.1><xsl:value-of select="position()+2"/></OBX.1>
          <OBX.2>
            <xsl:call-template name="FunctionSentinelToHl7DataTypes">
              <xsl:with-param name="type" select="Type"/>
              <xsl:with-param name="value" select="Value"/>
            </xsl:call-template>
          </OBX.2>
          <OBX.3><xsl:value-of select ="Name"/></OBX.3>
          <OBX.5>
            <xsl:call-template name="ConvertMeasurementValueToHl7">
              <xsl:with-param name="valueToConvert" select="Value"/>
              <xsl:with-param name="valueType" select="Type"/>
            </xsl:call-template>
          </OBX.5>
          <OBX.6>
            <xsl:call-template name="FunctionSentinelToHl7Units"><xsl:with-param name="unit" select="Units"/></xsl:call-template>
          </OBX.6>
          <OBX.11><xsl:value-of select="Status"/></OBX.11>
        </OBX>
	   </xsl:for-each>
-->
    </Hl7XmlMessage>
  </xsl:template>
</xsl:stylesheet>