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
        <MSH.4>TestPartner</MSH.4>
        <MSH.5>TestFacility</MSH.5>
        <MSH.6>
          <xsl:value-of select="$now"/>
        </MSH.6>
        <MSH.8>
          <MSH.8.1>ORU</MSH.8.1>
          <MSH.8.2>R01</MSH.8.2>
        </MSH.8>
        <MSH.9>
          <xsl:value-of select="$MessageID"/>
        </MSH.9>
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
          <PID.11.4><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Address/cmf:CountryRegion"/></PID.11.4>
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
          <PV1.3.1>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:PointOfCare"/>
          </PV1.3.1>
          <PV1.3.2>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:Ward"/>
          </PV1.3.2>
          <PV1.3.3>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:Bed"/>
          </PV1.3.3>
          <PV1.3.4>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Location/cmf:Facility"/>
          </PV1.3.4>
        </PV1.3>
        <PV1.7>
          <PV1.7.1>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:StaffNumber"/>
          </PV1.7.1>
          <PV1.7.2>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:FamilyName"/>
          </PV1.7.2>
          <PV1.7.3>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:GivenName"/>
          </PV1.7.3>
          <PV1.7.6>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Attending/cmf:Title"/>
          </PV1.7.6>
        </PV1.7>
        <PV1.8>
          <PV1.8.1>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:StaffNumber"/>
          </PV1.8.1>
          <PV1.8.2>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:FamilyName"/>
          </PV1.8.2>
          <PV1.8.3>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:GivenName"/>
          </PV1.8.3>
          <PV1.8.6>
            <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:Referring/cmf:Title"/>
          </PV1.8.6>
        </PV1.8>
        <PV1.19>
          <xsl:value-of select="/cmf:Message/cmf:Patient/cmf:Visit/cmf:VisitNumber"/>
        </PV1.19>
        <PV1.44>
          <xsl:call-template name="FunctionXmlToHl7DateTime">
            <xsl:with-param name="dateTime" select="/cmf:Message/cmf:Patient/cmf:Admitted"/>
          </xsl:call-template>
        </PV1.44>
      </PV1>
      <OBR>
        <OBR.1>1</OBR.1>
        <OBR.2>
          <xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:PlacerNumber"/>
        </OBR.2>
        <OBR.3>
          <xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:FillerNumber"/>
        </OBR.3>
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
    </Hl7XmlMessage>
  </xsl:template>
</xsl:stylesheet>