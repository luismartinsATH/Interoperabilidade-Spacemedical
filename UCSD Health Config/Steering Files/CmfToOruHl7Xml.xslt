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
        <MSH.3>CARDIOLOGY</MSH.3>
        <MSH.4>EPIC</MSH.4>
        <!-- <MSH.5>TestFacility</MSH.5> --><!-- customer want the Facility sent in MSH 3 to be returned in MSH 5  lms 9-26-2017 -->
        <MSH.5>UC SAN DIEGO</MSH.5>		
		
		<MSH.6><xsl:value-of select="$now"/></MSH.6>
        <MSH.8>
          <MSH.8.1>ORU</MSH.8.1>
          <MSH.8.2>R01</MSH.8.2>
        </MSH.8>
        <MSH.9><xsl:value-of select="$MessageID"/></MSH.9>
        <MSH.10>P</MSH.10>     <!--  numbering sequences are off by 1 this is actually MSH.11.1  -->       
        <MSH.11>2.3.1</MSH.11>  <!--  numbering sequences are off by 1 this is actually MSH.12.1  -->    
      </MSH>
      <PID>
		<PID.3>
		  <PID.3.1><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:PatientNumber"/>^^^PID</PID.3.1>  <!-- adding PID in 3.4 -->
        <!--  <PID.3.4><xsl:value-of select="cmf:Message/cmf:Patient/cmf:PatientID/cmf:Organisation"/></PID.3.4> --> <!-- remove the Org. per customer 3/6/2018 lms -->
        </PID.3>
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
		<PID.18><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:PatientNumber3"/></PID.18> 
		<!-- added Patient ID3 from same segment as the order lms 11-7-2017 -->
     <!--   <PID.19><xsl:value-of select="/cmf:Message/cmf:Patient/cmf:PatientID/cmf:PatientNumber2"/></PID.19> --> <!-- remove per customer lms 3/6/2018 -->
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
        <OBR.3><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:FillerNumber"/></OBR.3><!-- change to Order Number(PlacerNumber) for unique Test ID lms 12-18-2018    -->
<!--
        <OBR.4>
          <OBR.4.1>
            <xsl:call-template name="FunctionSentinelTestTypeToHl7">
              <xsl:with-param name="procedure" select="/cmf:Message/cmf:Test/cmf:TestTypeName"/>
            </xsl:call-template>
          </OBR.4.1>
          <OBR.4.2>
            <xsl:call-template name="FunctionSentinelTestTypeToHl7CodeSet">
              <xsl:with-param name="procedure" select="/cmf:Message/cmf:Test/cmf:TestTypeName"/>
            </xsl:call-template>
          </OBR.4.2>
        </OBR.4>
-->		
					<!-- larry edied this to return the Procedure code sent from EMR to EMR  -->
		<OBR.4>
			<OBR.4.1><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:Procedure"/></OBR.4.1>
		</OBR.4>		
		
        <OBR.7>
          <xsl:call-template name="FunctionXmlToHl7DateTime">
            <xsl:with-param name="dateTime" select="/cmf:Message/cmf:Test/cmf:StartDateTime"/>
          </xsl:call-template>
        </OBR.7>
        <OBR.16>
          <xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:OrderPlacer"/>
        </OBR.16>
		<!--
        <OBR.25>
          <xsl:call-template name="FunctionCmfReportStatusToHl7">
            <xsl:with-param name="interpreter" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Interpreter/text()"></xsl:with-param>
          </xsl:call-template>
        </OBR.25>
		-->
		<OBR.25>
		  <xsl:call-template name="FunctionCmfReportStatus">
            <xsl:with-param name="testreportstatus" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Status"/>
          </xsl:call-template>
		</OBR.25>
		
		<OBR.32>
		       <!-- Send Signing Physician in outbound ORU  lms 9-12-2017  -->
          <OBR.32.1><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterStaffNumber"/></OBR.32.1>
          <OBR.32.2><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterFamilyName"/></OBR.32.2>
          <OBR.32.3><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterGivenName"/></OBR.32.3>
          <OBR.32.6><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterTitle"/></OBR.32.6>
		</OBR.32>
		
		<OBR.35>
		       <!-- Send Signing Physician in outbound ORU  lms 9-12-2017  -->
          <OBR.35.1><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterStaffNumber"/></OBR.35.1>
          <OBR.35.2><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterFamilyName"/></OBR.35.2>
          <OBR.35.3><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterGivenName"/></OBR.35.3>
          <OBR.35.6><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterTitle"/></OBR.35.6>
		  <OBR.35.7><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Interpreter"/></OBR.35.7>
		</OBR.35>
		
      </OBR>
<!--
      <OBX>
        <OBX.1>1</OBX.1>
        <OBX.2>ED</OBX.2>
		
        <OBX.3>
          <OBX.3.1>
            <xsl:call-template name="FunctionSentinelTestTypeToHl7">
              <xsl:with-param name="procedure" select="/cmf:Message/cmf:Test/cmf:TestTypeName"/>
              <xsl:with-param name="testTypeName" select="/cmf:Message/cmf:Test/cmf:TestTypeName"/>
            </xsl:call-template>
          </OBX.3.1>
          <OBX.3.2>
            <xsl:call-template name="FunctionSentinelTestTypeToHl7CodeSet">
              <xsl:with-param name="procedure" select="/cmf:Message/cmf:Test/cmf:TestTypeName"/>
            </xsl:call-template>
          </OBX.3.2>
        </OBX.3>
		

		<OBX.4><OBX.4.1><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:Procedure"/></OBX.4.1></OBX.4>		

        <OBX.5>
          <OBX.5.1>1.2.826.0.1.921452</OBX.5.1>
          <OBX.5.2>Application</OBX.5.2>
          <OBX.5.3>PDF</OBX.5.3>
          <OBX.5.4>Base64</OBX.5.4>
          <OBX.5.5><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:ReportData"/></OBX.5.5>
        </OBX.5>
        <OBX.11>
		  <xsl:call-template name="FunctionCmfReportStatus">
            <xsl:with-param name="testreportstatus" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Status"/>
          </xsl:call-template>

        </OBX.11>
      </OBX>
-->
<!--  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ UCSD  USED for the MDM Message PDF ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   -->	   	  
      <OBX>
	    <OBX.1><xsl:value-of select="position()+1"/></OBX.1> 
       <!--  <OBX.1>2</OBX.1>  -->
        <OBX.2>ED</OBX.2>
		<OBX.3>MDM</OBX.3>
					<!-- larry edied this to return the Procedure code sent from EMR to EMR  -->
		<OBX.4><OBX.4.1><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:Procedure"/></OBX.4.1></OBX.4>		

        <OBX.5>
          <OBX.5.1>1.2.826.0.1.921452</OBX.5.1>
          <OBX.5.2>Application</OBX.5.2>
          <OBX.5.3>PDF</OBX.5.3>
          <OBX.5.4>Base64</OBX.5.4>
          <OBX.5.5><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:ReportData"/></OBX.5.5>
        </OBX.5>
        <OBX.11>
		  <xsl:call-template name="FunctionCmfReportStatus">
            <xsl:with-param name="testreportstatus" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Status"/>
          </xsl:call-template>
        </OBX.11>
      </OBX>		  
<!--  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ UCSD  USED for the MDM Message PDF ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   -->	   	  


	  
			<!-- This is the mesurements segments of the HL7 results   --> 
			<!--  with all Summary Statements have been removed see(contains statement) Larry Seieroe modified this on Nov. 6 2018 lms -->

	<xsl:for-each select="/cmf:Message/cmf:ArrayOfMeasurement/cmf:Measurement">
	<xsl:sort select ="substring(cmf:Value, 1)" data-type="number" order="descending"/>  <!--  sorts needed to keep the position() correct -->
	<xsl:sort select ="substring(cmf:Type, 1)" data-type="number" />   
	<xsl:if test="not(contains(cmf:Name,'Statement')) ">
        <OBX>

          <OBX.1><xsl:value-of select="position()+2"/></OBX.1> 
          <OBX.2>
            <xsl:call-template name="FunctionSentinelToHl7DataTypes">
              <xsl:with-param name="type" select="cmf:Type"/>
              <xsl:with-param name="value" select="cmf:Value"/>
            </xsl:call-template>
          </OBX.2>

          <OBX.3>
		  <OBX.3.1><xsl:value-of select ="cmf:Name"/></OBX.3.1><OBX.3.3>SENTINELLRR</OBX.3.3>
		  </OBX.3>  

          <OBX.5>
            <xsl:call-template name="ConvertMeasurementValueToHl7">
              <xsl:with-param name="valueToConvert" select="cmf:Value"/>
              <xsl:with-param name="valueType" select="cmf:Type"/>
            </xsl:call-template>
          </OBX.5>
          <OBX.6>
            <xsl:call-template name="FunctionSentinelToHl7Units">
              <xsl:with-param name="unit" select="cmf:Units"/>
            </xsl:call-template>
          </OBX.6>
		  
 
          <OBX.11>
		  <xsl:call-template name="FunctionCmfReportStatus">
            <xsl:with-param name="testreportstatus" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Status"/>
          </xsl:call-template><xsl:value-of select="cmf:Status"/>
		  </OBX.11>
		  
        </OBX>
   </xsl:if>
   </xsl:for-each>
<!-- End of Mesurements segments -->	

			<!-- *** Send first line of Physician Intrepretation with a header line indicating Physician Intrepretation  with 2 carrage returns after ***   -->
	<NTE>
		<NTE.1>1</NTE.1> 
		<NTE.2>SI</NTE.2>
  	    <NTE.3>Physician Intrepretation: \.br\ \.br\</NTE.3>

		<NTE.4>Result Comments</NTE.4>   <!-- ???  font-weight="bold" or style="font-weight:bold;text-decoration:underline;" -->
	    <NTE.11>
		  <xsl:call-template name="FunctionCmfReportStatus">
            <xsl:with-param name="testreportstatus" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Status"/>
          </xsl:call-template><xsl:value-of select="cmf:Status"/>
	    </NTE.11>
	</NTE> 	 		
			
	  <!--  **********  send the comments out in single NTE segment  ************ -->
	<NTE>
		<NTE.1>1</NTE.1> 
		<NTE.2>SI</NTE.2>
  	    <NTE.3>
				<xsl:call-template name="line">  
					<xsl:with-param name="Comments" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Comments"/>  
				</xsl:call-template>
 	    </NTE.3>

		<NTE.4>Result Comments</NTE.4>
	    <NTE.11>
		  <xsl:call-template name="FunctionCmfReportStatus">
            <xsl:with-param name="testreportstatus" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Status"/>
          </xsl:call-template><xsl:value-of select="cmf:Status"/>
	    </NTE.11>
	</NTE> 	 

	<NTE>
		<NTE.1>1</NTE.1> 
		<NTE.2>SI</NTE.2>
  	    <NTE.3>\.br\Physician Signing Report: <xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterGivenName"/>,.<xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterFamilyName"/>,.<xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterTitle"/>\.br\<xsl:value-of select="$now"/>\.br\</NTE.3>
		<NTE.4>Result Comments</NTE.4>   <!--  &#x20; &#x20; this represents 2 "spaces"  font-weight="bold" or style="font-weight:bold;text-decoration:underline;" -->
	    <NTE.11>
		  <xsl:call-template name="FunctionCmfReportStatus">
            <xsl:with-param name="testreportstatus" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Status"/>
          </xsl:call-template><xsl:value-of select="cmf:Status"/>
	    </NTE.11>
	</NTE> 	 		
			

	
	  
<!--  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ UCSD ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   -->	  
     <TXA>
        <TXA.1>1</TXA.1>
		<TXA.2><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:Procedure"/></TXA.2>	
		<!-- Send Procedure code to Mirth. Mirth will change procedure code to SL01  SL02 depending on Test type CARD15 or CARD7 -->
		<TXA.3>TX</TXA.3>
		<TXA.4><xsl:value-of select="$now"/></TXA.4>
		
        <TXA.6><xsl:value-of select="$now"/></TXA.6>
		
        <TXA.7>
          <xsl:call-template name="FunctionXmlToHl7DateTime">
            <xsl:with-param name="dateTime" select="/cmf:Message/cmf:Test/cmf:StartDateTime"/>
          </xsl:call-template>
        </TXA.7>
        <TXA.8>
          <xsl:call-template name="FunctionXmlToHl7DateTime">
            <xsl:with-param name="dateTime" select="/cmf:Message/cmf:Test/cmf:StartDateTime"/>
          </xsl:call-template>
        </TXA.8>	
        <TXA.12>
          <TXA.12.3><xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:Procedure"/></TXA.12.3> 
        </TXA.12>				  <!-- place the procedure code in the outbound. lms   for the doument type translation -->
        <TXA.16>
          <xsl:value-of select="/cmf:Message/cmf:Orders/cmf:Order/cmf:OrderPlacer"/>
        </TXA.16>
		
		<!--
        <TXA.25>
          <xsl:call-template name="FunctionCmfReportStatusToHl7">
            <xsl:with-param name="interpreter" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Interpreter/text()"></xsl:with-param>
          </xsl:call-template>
        </TXA.25>
		-->
		<TXA.25>
		  <xsl:call-template name="FunctionCmfReportStatus">
            <xsl:with-param name="testreportstatus" select="/cmf:Message/cmf:Reports/cmf:Report/cmf:Status"/>
          </xsl:call-template>
		</TXA.25>
		<TXA.32>
		       <!-- Send Signing Physician in outbound ORU  lms 9-12-2017  -->
          <TXA.32.1><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterStaffNumber"/></TXA.32.1>
          <TXA.32.2><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterFamilyName"/></TXA.32.2>
          <TXA.32.3><xsl:value-of select="/cmf.Message/cmf:Reports/cmf:Report/cmf:InterpreterGivenName"/></TXA.32.3>
          <TXA.32.6><xsl:value-of select="/cmf:Message/cmf:Reports/cmf:Report/cmf:InterpreterTitle"/></TXA.32.6>
		</TXA.32>		
      </TXA>
<!--  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ UCSD Used for the MDM message ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   -->	   	  
<!--
Test Port for MDM / TXA 10.196.16.202  port 33316
Prod Port for MDM / TXA 10.196.19.75   port 44416
-->

	  
    </Hl7XmlMessage>
  </xsl:template>
</xsl:stylesheet>