Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275463AbTHNT7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275464AbTHNT7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:59:37 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:24745 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S275463AbTHNT7f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:59:35 -0400
Subject: [PATCH] Add SELinux entry to MAINTAINERS
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1060891164.13964.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Aug 2003 15:59:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a SELINUX entry to the MAINTAINERS file.

 MAINTAINERS |   10 ++++++++++
 1 files changed, 10 insertions(+)

===== MAINTAINERS 1.164 vs edited =====
--- 1.164/MAINTAINERS	Sat Aug  9 05:23:59 2003
+++ edited/MAINTAINERS	Thu Aug 14 15:50:02 2003
@@ -1658,6 +1658,16 @@
 W:	http://www.weinigel.se
 S:	Supported
 
+SELINUX SECURITY MODULE
+P:	Stephen Smalley
+M:	sds@epoch.ncsc.mil
+P:	James Morris
+M:	jmorris@redhat.com
+L:	linux-kernel@vger.kernel.org (kernel issues)
+L: 	selinux@tycho.nsa.gov (general discussion)
+W:	http://www.nsa.gov/selinux
+S:	Supported
+
 SGI VISUAL WORKSTATION 320 AND 540
 P:	Andrey Panin
 M:	pazke@donpac.ru


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

