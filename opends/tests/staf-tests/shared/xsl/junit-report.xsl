<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--
 ! CDDL HEADER START
 !
 ! The contents of this file are subject to the terms of the
 ! Common Development and Distribution License, Version 1.0 only
 ! (the "License").  You may not use this file except in compliance
 ! with the License.
 ! 
 ! You can obtain a copy of the license at
 ! trunk/opends/resource/legal-notices/CDDLv1_0.txt
 ! or http://forgerock.org/license/CDDLv1.0.html.
 ! See the License for the specific language governing permissions
 ! and limitations under the License.
 ! 
 ! When distributing Covered Code, include this CDDL HEADER in each
 ! file and include the License file at
 ! trunk/opends/resource/legal-notices/CDDLv1_0.txt.  If applicable,
 ! add the following below this CDDL HEADER, with the fields enclosed
 ! by brackets "[]" replaced with your own identifying information:
 !      Portions Copyright [yyyy] [name of copyright owner]
 !
 ! CDDL HEADER END
 !
 !      Copyright 2011 ForgeRock AS.
 ! -->

<xsl:output method="xml" indent="yes" />
<xsl:template match="/">
<testsuites>
  <xsl:variable name="ftpath"           select="/qa/functional-tests"/>
  <xsl:variable name="id"               select="$ftpath/identification"/>
  <xsl:variable name="results"          select="$ftpath/results"/>
  <xsl:variable name="testgroup"        select="$results/testgroup"/>
  <xsl:variable name="testsuite"        select="$testgroup/testsuite"/>
  <xsl:variable name="testcase"         select="$testsuite/testcase"/>
  <xsl:variable name="total-tests"      select="count($testcase)"/>
  <xsl:variable name="pass-tests"       select="count($testcase[@result='pass'])"/>
  <xsl:variable name="kfail-tests"      select="count($testcase/issues)"/>
  <xsl:variable name="fail-tests"       select="count($testcase[@result='fail'])"/>
  <xsl:variable name="inconc-tests"     select="count($testcase[@result='unknown'])"/>
  <testsuite name="FunctionalTests"
    tests="{$total-tests}" time="0"
    failures="{$fail-tests}" errors="0"
    skipped="{$inconc-tests}">
    
    <xsl:for-each select="$testsuite">
      <xsl:variable name="testName" select="@testName"/>
      <xsl:variable name="message" select="'no message'"/>
      <xsl:for-each select="$testcase">
        <xsl:variable name="className" select="@name"/>
        <xsl:variable name="outcome" select="@result"/>
        <testcase classname="{$className}"
          name="{$testName}"
          time="{@duration}">
          
          <xsl:if test="contains($outcome, 'fail')">
            <failure>
              <xsl:value-of select="$message" />
            </failure>
          </xsl:if>
        </testcase>
      </xsl:for-each>
    </xsl:for-each>
  
  </testsuite>
</testsuites>
</xsl:template>
</xsl:stylesheet>
