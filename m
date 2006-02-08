Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWBHMfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWBHMfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWBHMfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:35:24 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:54032 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030388AbWBHMfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:35:22 -0500
Date: Wed, 8 Feb 2006 13:35:20 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Frank Pavlic <fpavlic@de.ibm.com>,
       Andreas Herrmann <aherrman@de.ibm.com>
Subject: [patch 04/10] s390: update maintainers file
Message-ID: <20060208123520.GE1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Update URL for s390 and add maintainers for s390 networking and zfcp driver.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 MAINTAINERS |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/MAINTAINERS linux-2.6-patched/MAINTAINERS
--- linux-2.6/MAINTAINERS	2006-02-08 10:48:26.000000000 +0100
+++ linux-2.6-patched/MAINTAINERS	2006-02-08 10:48:44.000000000 +0100
@@ -2232,7 +2232,23 @@ P:	Martin Schwidefsky
 M:	schwidefsky@de.ibm.com
 M:	linux390@de.ibm.com
 L:	linux-390@vm.marist.edu
-W:	http://oss.software.ibm.com/developerworks/opensource/linux390
+W:	http://www.ibm.com/developerworks/linux/linux390/
+S:	Supported
+
+S390 NETWORK DRIVERS
+P:	Frank Pavlic
+M:	fpavlic@de.ibm.com
+M:	linux390@de.ibm.com
+L:	linux-390@vm.marist.edu
+W:	http://www.ibm.com/developerworks/linux/linux390/
+S:	Supported
+
+S390 ZFCP DRIVER
+P:	Andreas Herrmann
+M:	aherrman@de.ibm.com
+M:	linux390@de.ibm.com
+L:	linux-390@vm.marist.edu
+W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 
 SAA7146 VIDEO4LINUX-2 DRIVER
