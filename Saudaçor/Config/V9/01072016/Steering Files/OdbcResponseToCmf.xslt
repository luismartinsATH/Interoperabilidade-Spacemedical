<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">
  <xsl:include href="CommonTemplates.xslt"/>

  <!-- Date/time when the XSLT transform was called.  Used in message header -->
  <xsl:param name="now"/>

  <xsl:template match="/">
    <Message>
      <Processing>
        <Action type="InsertOrUpdate"/>
        <MessageType>ODBC Query Response</MessageType>
        <MessageID>
          <xsl:value-of select="/OdbcQueryResponse/CorrelationID"/>
        </MessageID>
      </Processing>
      <Patient>
        <PatientID>
          <xsl:variable name="GivenName" select="/OdbcQueryResponse/FNAME"/>
          <xsl:choose>
            <xsl:when test="string-length($GivenName) > 0">
              <PatientNumber>
                <xsl:value-of select="/OdbcQueryResponse/DIST_NUM"/>
              </PatientNumber>
            </xsl:when>
            <xsl:otherwise>
              <PatientNumber></PatientNumber>
            </xsl:otherwise>
          </xsl:choose>
          <PatientNumber2>
            <xsl:call-template name="FunctionFormatPatientID">
              <xsl:with-param name="ID" select="/OdbcQueryResponse/NHS_NUM"/>
            </xsl:call-template>
          </PatientNumber2>
          <PatientNumber3>
            <xsl:value-of select="/OdbcQueryResponse/NHSNUM_STATUS"/>
          </PatientNumber3>
        </PatientID>
        <GivenName>
          <xsl:value-of select="/OdbcQueryResponse/FNAME"/>
        </GivenName>
        <FamilyName>
          <xsl:value-of select="/OdbcQueryResponse/SNAME"/>
        </FamilyName>
        <MaidenName>
          <xsl:value-of select="/OdbcQueryResponse/PREV_SNAME1"/>
        </MaidenName>
        <Title>
          <xsl:value-of select="/OdbcQueryResponse/TITLE"/>
        </Title>
        <DateOfBirth>
          <xsl:variable name="date" select="/OdbcQueryResponse/DOB"/>
          <xsl:value-of select="utils:OdbcUKDateTimeToXmlDate($date)" />
        </DateOfBirth>
        <Gender>
          <xsl:variable name="gender" select="/OdbcQueryResponse/SEX"/>
          <xsl:choose>
            <xsl:when test="$gender='F'">2</xsl:when>
            <xsl:when test="$gender='M'">1</xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
          </xsl:choose>
        </Gender>
        <Ethnicity>
          <xsl:call-template name="FunctionNHSToSentinelEthnicity">
            <xsl:with-param name="ethnicityCode" select="/OdbcQueryResponse/ETHNIC"/>
          </xsl:call-template>
        </Ethnicity>
        <Address>
          <AddressLine1>
            <xsl:value-of select="/OdbcQueryResponse/ADDR1"/>
          </AddressLine1>
          <AddressLine2>
            <xsl:value-of select="/OdbcQueryResponse/ADDR2"/>
          </AddressLine2>
          <City>
            <xsl:value-of select="/OdbcQueryResponse/ADDR3"/>
          </City>
          <CountyRegion>
            <xsl:value-of select="/OdbcQueryResponse/ADDR4"/>
          </CountyRegion>
          <PostZipcode>
            <xsl:value-of select="/OdbcQueryResponse/POSTCODE"/>
          </PostZipcode>
          <Country>
          </Country>
          <HomePhone>
            <xsl:value-of select="/OdbcQueryResponse/HTEL"/>
          </HomePhone>
          <WorkPhone>
            <xsl:value-of select="/OdbcQueryResponse/WTEL"/>
          </WorkPhone>
        </Address>
        <Deceased>
          <xsl:variable name="date" select="/OdbcQueryResponse/DOD"/>
          <xsl:value-of select="utils:OdbcUKDateTimeToXmlDate($date)" />
        </Deceased>
        <ContactFamilyName>
          <xsl:value-of select="/OdbcQueryResponse/NOKSurname"/>
        </ContactFamilyName>
        <ContactGivenName>
          <xsl:value-of select="/OdbcQueryResponse/NOKForenames"/>
        </ContactGivenName>
        <ContactHomePhone>
          <xsl:value-of select="/OdbcQueryResponse/NOKHomePhone"/>
        </ContactHomePhone>
        <ContactRelationship>
          <xsl:value-of select="/OdbcQueryResponse/NOKRelation"/>
        </ContactRelationship>
      </Patient>
    </Message>
  </xsl:template>

  <!-- Converts from Ethnicity codes to strings. -->
  <xsl:template name="FunctionNHSToSentinelEthnicity">
    <xsl:param name="ethnicityCode"/>
    <xsl:choose>
      <xsl:when test="$ethnicityCode='AA'">BRITISH - WHITE</xsl:when>
      <xsl:when test="$ethnicityCode='BB'">IRISH</xsl:when>
      <xsl:when test="$ethnicityCode='CC'">ANY OTHER WHITE BACKGROUND</xsl:when>
      <xsl:when test="$ethnicityCode='DD'">WHITE AND BLACK CARIBBEAN</xsl:when>
      <xsl:when test="$ethnicityCode='EE'">WHITE AND BLACK AFRICAN</xsl:when>
      <xsl:when test="$ethnicityCode='FF'">WHITE AND ASIAN</xsl:when>
      <xsl:when test="$ethnicityCode='GG'">ANY OTHER MIXED BACKGROUND</xsl:when>
      <xsl:when test="$ethnicityCode='HH'">INDIAN</xsl:when>
      <xsl:when test="$ethnicityCode='JJ'">PAKISTANI</xsl:when>
      <xsl:when test="$ethnicityCode='KK'">BANGLDESHI</xsl:when>
      <xsl:when test="$ethnicityCode='LL'">ANY OTHER ASIAN BACKGROUND</xsl:when>
      <xsl:when test="$ethnicityCode='MM'">CARIBBEAN</xsl:when>
      <xsl:when test="$ethnicityCode='NN'">AFRICAN</xsl:when>
      <xsl:when test="$ethnicityCode='PP'">ANY OTHER BLACK BACKGROUND</xsl:when>
      <xsl:when test="$ethnicityCode='RR'">CHINESE</xsl:when>
      <xsl:when test="$ethnicityCode='SS'">ANY OTHER ETHNIC GROUP</xsl:when>
      <xsl:when test="$ethnicityCode='U'">Unknown</xsl:when>
      <xsl:when test="$ethnicityCode='ZZ'">NOT STATED/COLLECTED</xsl:when>
      <xsl:otherwise>Unknown</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>