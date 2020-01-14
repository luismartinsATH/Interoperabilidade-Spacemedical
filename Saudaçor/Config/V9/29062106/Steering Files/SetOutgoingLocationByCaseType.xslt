<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="urn:dmr-cmf" xmlns:cmf="urn:dmr-cmf" xmlns:utils="urn:CodeUtils">

  <!-- This stylesheet updates the children of the Location CMF node depending
  on the class of the visit (case type) of the case data. -->

  <xsl:template match="/">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="cmf:Location">
    <xsl:choose>
      <xsl:when  test="/cmf:Message/cmf:Patient/cmf:Visit/cmf:CaseType/text()='OutPatient'">
        <Location>
          <PointOfCare xmlns="urn:dmr-cmf">
            <xsl:value-of select="cmf:OutPointOfCare"/>
          </PointOfCare>
          <Ward xmlns="urn:dmr-cmf">
            <xsl:value-of select="cmf:OutWard"/>
          </Ward>
          <Bed xmlns="urn:dmr-cmf">
            <xsl:value-of select="cmf:OutBed"/>
          </Bed>
          <Facility xmlns="urn:dmr-cmf">
            <xsl:value-of select="cmf:OutFacility"/>
          </Facility>
        </Location>
      </xsl:when>
      <xsl:otherwise>
        <Location>
          <PointOfCare xmlns="urn:dmr-cmf">
            <xsl:value-of select="cmf:InPointOfCare"/>
          </PointOfCare>
          <Ward xmlns="urn:dmr-cmf">
            <xsl:value-of select="cmf:InWard"/>
          </Ward>
          <Bed xmlns="urn:dmr-cmf">
            <xsl:value-of select="cmf:InBed"/>
          </Bed>
          <Facility xmlns="urn:dmr-cmf">
            <xsl:value-of select="cmf:InFacility"/>
          </Facility>
        </Location>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- By default, just copy source node to the output tree. -->
  <xsl:template match="node()">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>