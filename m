Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVAVNKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVAVNKq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 08:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVAVNKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 08:10:46 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:41862 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262710AbVAVNKm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 08:10:42 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, gilbertd@treblig.org, spyro@f2s.com,
       James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050122131038.25445.64307.66429@localhost.localdomain>
Subject: [PATCH] arm26: new maintainer of Archimedes floppy and hard disk drivers
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [70.16.225.90] at Sat, 22 Jan 2005 07:10:39 -0600
Date: Sat, 22 Jan 2005 07:10:41 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After getting in touch with the listed maintainer of the ARM26 floppy and hard drive
maintainer, I found out that he had passed it on to Ian Molton.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm2-original/MAINTAINERS linux-2.6.11-rc1-mm2/MAINTAINERS
--- linux-2.6.11-rc1-mm2-original/MAINTAINERS	2005-01-20 16:33:14.000000000 -0500
+++ linux-2.6.11-rc1-mm2/MAINTAINERS	2005-01-22 08:00:25.319860086 -0500
@@ -283,8 +283,8 @@
 S:	Maintained
 
 ARM MFM AND FLOPPY DRIVERS
-P:	Dave Gilbert
-M:	linux@treblig.org
+P:	Ian Molton
+M:	spyro@f2s.com
 S:	Maintained
 
 ARM/CORGI MACHINE SUPPORT
