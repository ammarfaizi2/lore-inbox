Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUCULlb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 06:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbUCULlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 06:41:31 -0500
Received: from relay-4m.club-internet.fr ([194.158.104.43]:20131 "EHLO
	relay-4m.club-internet.fr") by vger.kernel.org with ESMTP
	id S263636AbUCULl3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 06:41:29 -0500
From: pinotj@club-internet.fr
To: ysato@users.sourceforge.jp
Cc: linux-kernel@vger.kernel.org
Subject: [TYPO][2.6] H8/300 Kconfig
Date: Sun, 21 Mar 2004 12:41:14 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet3.1079869274.17273.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correct some typos

Regards,

Jerome Pinot

diff -Nru a/arch/h8300/Kconfig b/arch/h8300/Kconfig
--- a/arch/h8300/Kconfig	2004-03-17 14:13:27.000000000 +0900
+++ b/arch/h8300/Kconfig	2004-03-17 14:14:11.000000000 +0900
@@ -57,17 +57,17 @@
 config H8300H_AKI3068NET
 	bool "AE-3068/69"
 	help
-	  AKI-H8/3068F / AKI-H8/3069F Flashmicom LAN Board Suppot
+	  AKI-H8/3068F / AKI-H8/3069F Flashmicom LAN Board Support
 	  More Information. (Japanese Only)
 	  <http://akizukidensi.com/catalog/h8.html>
-	  AE-3068/69 Evalution Board Support
+	  AE-3068/69 Evaluation Board Support
 	  More Information.
 	  <http://www.microtronique.com/ae3069lan.htm>
 
 config H8300H_H8MAX
 	bool "H8MAX"
 	help
-	  H8MAX Evalution Board Suooprt
+	  H8MAX Evaluation Board Support
 	  More Information. (Japanese Only)
 	  <http://strawberry-linux.com/h8/index.html>
 
@@ -81,7 +81,7 @@
 config H8S_EDOSK2674
 	bool "EDOSK-2674"
 	help
-	  Renesas EDOSK-2674R Evalution Board Support
+	  Renesas EDOSK-2674R Evaluation Board Support
 	  More Information.
 	  <http://www.azpower.com/H8-uClinux/index.html>
  	  <http://www.eu.renesas.com/tools/edk/support/edosk2674.html>

