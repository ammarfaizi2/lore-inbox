Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267257AbSLKSax>; Wed, 11 Dec 2002 13:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267264AbSLKSax>; Wed, 11 Dec 2002 13:30:53 -0500
Received: from [81.2.122.30] ([81.2.122.30]:5894 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267257AbSLKSaw>;
	Wed, 11 Dec 2002 13:30:52 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212111850.gBBIoCOL009048@darkstar.example.net>
Subject: [TRIVIAL][PATCH] fix spelling mistake
To: linux-kernel@vger.kernel.org
Date: Wed, 11 Dec 2002 18:50:12 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.9042.1039632612--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.9042.1039632612--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I posted this an hour or so ago, but it doesn't seem to have appeared
on the list.

John.

--%--multipart-mixed-boundary-1.9042.1039632612--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: ASCII English text
Content-Disposition: attachment; filename="patch"

--- linux-2.4.20-pre1-orig/drivers/scsi/README.ncr53c8xx	2002-12-11 17:14:48.000000000 +0000
+++ linux-2.4.20-pre1/drivers/scsi/README.ncr53c8xx	2002-12-11 17:18:24.000000000 +0000
@@ -1025,7 +1025,7 @@
 then it will for sure win the next SCSI BUS arbitration.
 
 Since, there is no way to know what devices are trying to arbitrate for the 
-BUS, using this feature can be extremally unfair. So, you are not advised 
+BUS, using this feature can be extremely unfair. So, you are not advised 
 to enable it, or at most enable this feature for the case the chip lost 
 the previous arbitration (boot option 'iarb:1').
 

--%--multipart-mixed-boundary-1.9042.1039632612--%--
