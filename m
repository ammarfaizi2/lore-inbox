Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272799AbTHEN60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272800AbTHEN60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:58:26 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:8642 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S272799AbTHEN6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:58:24 -0400
Date: Tue, 5 Aug 2003 15:58:20 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] 2 spelling patches in helps
Message-ID: <Pine.LNX.4.51.0308051556410.1321@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider these patches to fix spelling.

Regards,
Maciej Soltysiak

diff -u linux-2.6.0-test2/net/Kconfig linux-2.6.0-test2-mm4/net/Kconfig
--- linux-2.6.0-test2/net/Kconfig	2003-07-27 18:57:01.000000000 +0200
+++ linux-2.6.0-test2-mm4/net/Kconfig	2003-08-04 20:26:47.000000000 +0200
@@ -595,7 +602,7 @@
 	depends on EXPERIMENTAL
 	---help---
 	  This option enables NIC (Network Interface Card) hardware throttling
-	  during periods of extremal congestion. At the moment only a couple
+	  during periods of extreme congestion. At the moment only a couple
 	  of device drivers support it (really only one -- tulip, a modified
 	  8390 driver can be found at
 	  <ftp://ftp.inr.ac.ru/ip-routing/fastroute/fastroute-8390.tar.gz>).

diff -u linux-2.6.0-test2/Documentation/scsi/ncr53c8xx.txt linux-2.6.0-test2-mm4/Documentation/scsi/ncr53c8xx.txt
--- linux-2.6.0-test2/Documentation/scsi/ncr53c8xx.txt	2003-07-27 18:55:55.000000000 +0200
+++ linux-2.6.0-test2-mm4/Documentation/scsi/ncr53c8xx.txt	2003-08-04 20:27:40.000000000 +0200
@@ -1025,7 +1025,7 @@
 then it will for sure win the next SCSI BUS arbitration.

 Since, there is no way to know what devices are trying to arbitrate for the
-BUS, using this feature can be extremally unfair. So, you are not advised
+BUS, using this feature can be extremely unfair. So, you are not advised
 to enable it, or at most enable this feature for the case the chip lost
 the previous arbitration (boot option 'iarb:1').

