Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265394AbTLRXLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbTLRXLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:11:46 -0500
Received: from opersys.com ([64.40.108.71]:40462 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S265394AbTLRXLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:11:43 -0500
Message-ID: <3FE234E4.8020500@opersys.com>
Date: Thu, 18 Dec 2003 18:14:44 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Updating real-time and nanokernel maintainers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply.

diff -urN linux-2.6.0/MAINTAINERS linux-2.6.0-correct-maintainers/MAINTAINERS
--- linux-2.6.0/MAINTAINERS	2003-12-17 21:58:57.000000000 -0500
+++ linux-2.6.0-correct-maintainers/MAINTAINERS	2003-12-18 14:21:49.000000000 -0500
@@ -181,6 +181,13 @@
  W:	http://www.tu-darmstadt.de/~tek01/projects/linux.html
  S:	Maintained

+ADEOS: ADAPTIVE DOMAIN ENVIRONMENT FOR OPERATING SYSTEMS
+P:	Philippe Gerum
+M:	rpm@xenomai.org
+L:	adeos-main@nongnu.org
+W:	www.adeos.org
+S:	Maintained
+
  ADVANSYS SCSI DRIVER
  P:	Bob Frey
  M:	linux@advansys.com
@@ -1664,11 +1671,11 @@
  L:	linux-kernel@vger.kernel.org
  S:	Maintained

-RTLINUX  REALTIME  LINUX
-P:	Victor Yodaiken
-M:	yodaiken@fsmlabs.com
-L:	rtl@rtlinux.org
-W:	www.rtlinux.org
+RTAI: REAL-TIME APPLICATION INTERFACE
+P:	Paolo Mantegazza
+M:	mantegazza@aero.polimi.it
+L:	rtai-dev@rtai.org
+W:	www.aero.polimi.it/~rtai/
  S:	Maintained

  S390


Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145




