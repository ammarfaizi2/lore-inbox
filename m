Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVHRJS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVHRJS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 05:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVHRJS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 05:18:26 -0400
Received: from odin2.bull.net ([192.90.70.84]:26535 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932141AbVHRJS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 05:18:26 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel@vger.kernel.org
Subject: Schedutils spec file for 1.5.0
Date: Thu, 18 Aug 2005 11:21:08 +0200
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EMFBDmlVW2LnL6N"
Message-Id: <200508181121.08934.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_EMFBDmlVW2LnL6N
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

	I found a minor error in the spec file schedutils.spec.

--Boundary-00=_EMFBDmlVW2LnL6N
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="diff.schedutils-1.5.0.spec"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff.schedutils-1.5.0.spec"

--- schedutils-1.5.0/schedutils.spec.orig	2004-09-24 19:27:45.000000000 +0200
+++ schedutils-1.5.0/schedutils.spec	2005-08-18 11:04:53.086563304 +0200
@@ -4,7 +4,7 @@
 
 Summary: Utilities for manipulating process scheduler attributes
 Name: schedutils
-Version: 1.4.0
+Version: 1.5.0
 Release: 1
 License: GPL
 Group: Applications/System

--Boundary-00=_EMFBDmlVW2LnL6N--
