Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVANRDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVANRDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 12:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVANRD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 12:03:29 -0500
Received: from avexch02.qlogic.com ([198.70.193.200]:6563 "EHLO
	avexch01.qlogic.com") by vger.kernel.org with ESMTP id S262026AbVANRCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 12:02:03 -0500
Subject: [PATCH] MAINTAINERS: add entry for qla2xxx driver.
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: QLogic Corporation
Date: Fri, 14 Jan 2005 09:02:12 -0800
Message-Id: <1105722132.12434.17.camel@plap.san.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-OriginalArrivalTime: 14 Jan 2005 16:58:56.0921 (UTC) FILETIME=[55F31090:01C4FA5A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for QLogic qla2xxx driver.

Signed-off-by: Andrew Vasquez <andrew.vasquez@qlogic.com>

 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+)

--- linux-2.6.11-rc1/MAINTAINERS.orig	2005-01-14 08:34:41.087661376 -0800
+++ linux-2.6.11-rc1/MAINTAINERS	2005-01-14 08:42:26.004983200 -0800
@@ -1828,6 +1828,12 @@
 L:	linux-arm-kernel@lists.arm.linux.org.uk
 S:	Maintained
 
+QLOGIC QLA2XXX FC-SCSI DRIVER
+P:	Andrew Vasquez
+M:	andrew.vasquez@qlogic.com
+L:	linux-scsi@vger.kernel.org
+S:	Supported
+
 QNX4 FILESYSTEM
 P:	Anders Larsen
 M:	al@alarsen.net

