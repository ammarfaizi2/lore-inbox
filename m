Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266058AbUFDW6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbUFDW6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266038AbUFDWzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:55:21 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:36481 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266040AbUFDWwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:52:50 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       davidm@hpl.hp.com, akpm@osdl.org, willy@debian.org
Subject: [PATCH] ia64 MAINTAINERS update
Date: Fri, 4 Jun 2004 15:51:25 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tzPwA9DosQhBL93"
Message-Id: <200406041551.25405.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tzPwA9DosQhBL93
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dave Hansen pointed out that linux-ia64@linuxia64.org is broken.  Since the 
list has moved and the domain is gone, update the list address and kill the 
URL.  I think willy has a new domain for ia64 Linux, but it was down for me, 
so I'll let him update the file later with the new URL if he wants to.

Jesse

--Boundary-00=_tzPwA9DosQhBL93
Content-Type: text/plain;
  charset="us-ascii";
  name="ia64-maintainers-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ia64-maintainers-update.patch"

===== MAINTAINERS 1.216 vs edited =====
--- 1.216/MAINTAINERS	Mon May 31 18:02:57 2004
+++ edited/MAINTAINERS	Fri Jun  4 15:49:17 2004
@@ -944,15 +944,14 @@
 IA64 (Itanium) PLATFORM
 P:	David Mosberger-Tang
 M:	davidm@hpl.hp.com
-L:	linux-ia64@linuxia64.org
-W:	http://www.linuxia64.org/
+L:	linux-ia64@vger.kernel.org
 S:	Maintained
 
 SN-IA64 (Itanium) SUB-PLATFORM
 P:	Jesse Barnes
 M:	jbarnes@sgi.com
 L:	linux-altix@sgi.com
-L:	linux-ia64@linuxia64.org
+L:	linux-ia64@vger.kernel.org
 W:	http://www.sgi.com/altix
 S:	Maintained
 

--Boundary-00=_tzPwA9DosQhBL93--
