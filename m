Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbUKSQLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUKSQLc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUKSQLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:11:32 -0500
Received: from mail0.lsil.com ([147.145.40.20]:15295 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261457AbUKSQLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:11:18 -0500
Message-ID: <91888D455306F94EBD4D168954A9457C5467A2@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: LSI Logic - SAS and FC PCI ID's
Date: Thu, 18 Nov 2004 16:59:57 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4CDCA.B4F799B0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4CDCA.B4F799B0
Content-Type: text/plain;
	charset="iso-8859-1"

Here are new PCI ID's for SAS and Fibre Channel
LSI Logic controllers.

Signed-off-by: Eric Moore <Eric.Moore@lsil.com>




------_=_NextPart_000_01C4CDCA.B4F799B0
Content-Type: application/octet-stream;
	name="pci_ids.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pci_ids.patch"

--- b/include/linux/pci_ids.h	2004-11-18 16:36:33.000000000 -0700=0A=
+++ a/include/linux/pci_ids.h	2004-11-18 16:54:48.497328464 -0700=0A=
@@ -176,10 +176,20 @@=0A=
 #define PCI_DEVICE_ID_LSI_FC919		0x0624=0A=
 #define PCI_DEVICE_ID_LSI_FC919_LAN	0x0625=0A=
 #define PCI_DEVICE_ID_LSI_FC929X	0x0626=0A=
+#define PCI_DEVICE_ID_LSI_FC939X	0x0642=0A=
+#define PCI_DEVICE_ID_LSI_FC949X	0x0640=0A=
 #define PCI_DEVICE_ID_LSI_FC919X	0x0628=0A=
 #define PCI_DEVICE_ID_NCR_YELLOWFIN	0x0701=0A=
 #define PCI_DEVICE_ID_LSI_61C102	0x0901=0A=
 #define PCI_DEVICE_ID_LSI_63C815	0x1000=0A=
+#define PCI_DEVICE_ID_LSI_SAS1064	0x0050=0A=
+#define PCI_DEVICE_ID_LSI_SAS1066	0x005E=0A=
+#define PCI_DEVICE_ID_LSI_SAS1068	0x0054=0A=
+#define PCI_DEVICE_ID_LSI_SAS1064A	0x005C=0A=
+#define PCI_DEVICE_ID_LSI_SAS1064E	0x0056=0A=
+#define PCI_DEVICE_ID_LSI_SAS1066E	0x005A=0A=
+#define PCI_DEVICE_ID_LSI_SAS1068E	0x0058=0A=
+#define PCI_DEVICE_ID_LSI_SAS1078	0x0060=0A=
 =0A=
 #define PCI_VENDOR_ID_ATI		0x1002=0A=
 /* Mach64 */=0A=

------_=_NextPart_000_01C4CDCA.B4F799B0--
