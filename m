Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269647AbUJAApg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269647AbUJAApg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 20:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbUJAApg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 20:45:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:62669 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269647AbUJAAnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 20:43:52 -0400
Date: Thu, 30 Sep 2004 17:41:33 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] doc: remove lingering PC-9800 param.
Message-Id: <20040930174133.312200a6.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove lingering PC-9800 doc.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 Documentation/kernel-parameters.txt |    3 ---
 1 files changed, 3 deletions(-)

diff -Naurp ./Documentation/kernel-parameters.txt~pc98_doc ./Documentation/kernel-parameters.txt
--- ./Documentation/kernel-parameters.txt~pc98_doc	2004-09-29 20:51:38.000000000 -0700
+++ ./Documentation/kernel-parameters.txt	2004-09-30 17:39:11.779516880 -0700
@@ -97,9 +97,6 @@ running once the system is up.
 			See header of drivers/scsi/53c7xx.c.
 			See also Documentation/scsi/ncr53c7xx.txt.
 
-	98busmouse.irq=	[HW,MOUSE] PC-9801 Bus Mouse Driver
-			Format: <irq>, default is 13
-
 	acpi=		[HW,ACPI] Advanced Configuration and Power Interface 
 			Format: { force | off | ht | strict }
 			force -- enable ACPI if default was off


--
