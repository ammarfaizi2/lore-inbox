Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWEFLMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWEFLMp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 07:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWEFLMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 07:12:45 -0400
Received: from tim.rpsys.net ([194.106.48.114]:20176 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750765AbWEFLMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 07:12:44 -0400
Subject: [PATCH] LED: Add maintainer entry for the LED subsystem
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 06 May 2006 12:12:33 +0100
Message-Id: <1146913953.6237.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a MAINTAINERS entry for the LED subsystem.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: git/MAINTAINERS
===================================================================
--- git.orig/MAINTAINERS	2006-05-04 23:12:39.000000000 +0100
+++ git/MAINTAINERS	2006-05-06 10:30:08.000000000 +0100
@@ -1602,6 +1602,11 @@
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
+LED SUBSYSTEM
+P:	Richard Purdie
+M:	rpurdie@rpsys.net
+S:	Maintained
+
 LEGO USB Tower driver
 P:	Juergen Stuber
 M:	starblue@users.sourceforge.net


