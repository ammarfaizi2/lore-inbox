Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268398AbTBNM7p>; Fri, 14 Feb 2003 07:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268412AbTBNMzo>; Fri, 14 Feb 2003 07:55:44 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:27406 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S268422AbTBNMxb>;
	Fri, 14 Feb 2003 07:53:31 -0500
Date: Fri, 14 Feb 2003 15:58:43 +0300
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] visws: MAINTAINERS file update (12/13)
Message-ID: <20030214125843.GL8230@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qySB1iFW++5nzUxH"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qySB1iFW++5nzUxH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

Looks like I'm a maintainer of visws support now :))

Please consider applying.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--qySB1iFW++5nzUxH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-maintainers

diff -urN -X /usr/share/dontdiff linux-2.5.60.vanilla/MAINTAINERS linux-2.5.60/MAINTAINERS
--- linux-2.5.60.vanilla/MAINTAINERS	Thu Feb 13 20:33:01 2003
+++ linux-2.5.60/MAINTAINERS	Thu Feb 13 20:42:02 2003
@@ -1547,11 +1547,11 @@
 S:	Supported
 
 SGI VISUAL WORKSTATION 320 AND 540
-P:	Bent Hagemark
-M:	bh@sgi.com
-P:	Ingo Molnar
-M:	mingo@redhat.com
-S:	Maintained
+P:	Andrey Panin
+M:	pazke@orbita1.ru
+L:	linux-visws@lists.sf.net
+W:	http://linux-visws.sf.net
+S:	Maintained for 2.5.
 
 SIS 5513 IDE CONTROLLER DRIVER
 P:	Lionel Bouton

--qySB1iFW++5nzUxH--
