Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbTIQRlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 13:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbTIQRlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 13:41:51 -0400
Received: from fmr09.intel.com ([192.52.57.35]:30922 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261964AbTIQRlu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 13:41:50 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH] ACPI maintainer change
Date: Wed, 17 Sep 2003 10:41:41 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EF12@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ACPI maintainer change
Thread-Index: AcN9QvR0BxCO6KbeQjCi7tiAVTANfA==
From: "Grover, Andrew" <andrew.grover@intel.com>
To: <torvalds@osdl.org>, "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, "acpi" <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 17 Sep 2003 17:41:43.0958 (UTC) FILETIME=[F5AD1360:01C37D42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Marcelo,

The following patch updates the maintainer entry for ACPI. Len has
already assumed most of this responsibility, as other projects demand my
attention.

My team will continue to maintain the OS-independent ACPI CA release,
but Len will be responsible for pulling ACPI CA updates into the Linux
release, and the rest of Linux-specific code in general.

This should apply cleanly against 2.6-bk-latest and against
2.4-bk-latest with an offset.

Regards -- Andy

--- 1.164/MAINTAINERS	Fri Sep 12 08:44:53 2003
+++ edited/MAINTAINERS	Wed Sep 17 10:20:28 2003
@@ -169,8 +169,8 @@
 S:	Supported
 
 ACPI
-P:	Andy Grover
-M:	andrew.grover@intel.com
+P:	Len Brown
+M:	len.brown@intel.com
 L:	acpi-devel@lists.sourceforge.net
 W:	http://sf.net/projects/acpi/
 S:	Maintained

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

