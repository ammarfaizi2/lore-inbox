Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271346AbTGQIYB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 04:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271360AbTGQIYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 04:24:01 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.10]:50830 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S271346AbTGQIX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 04:23:59 -0400
Date: Thu, 17 Jul 2003 04:38:45 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: [PATCH] Documentation Fix - Bug 939
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       thomas@dynajoo.ath.cx
Message-id: <200307170438.53062.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_eqe4UPslvPyAg3yjolnlcQ)"
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_eqe4UPslvPyAg3yjolnlcQ)
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Simple documentation fix in arch/h8300/README

http://bugme.osdl.org/show_bug.cgi?id=939

Josef "Jeff" Sipek, aka Jeff.

- -- 
Research, n.:
  Consider Columbus:
    He didn't know where he was going.
    When he got there he didn't know where he was.
    When he got back he didn't know where he had been.
    And he did it all on someone else's money.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FmCYwFP0+seVj/4RAr5/AKC3XVDlWJDH9XSxMu+E0blL3OmhbwCgsIUr
zXJH/hW92O5YwUIv6TDan1g=
=nDV0
-----END PGP SIGNATURE-----

--Boundary_(ID_eqe4UPslvPyAg3yjolnlcQ)
Content-type: text/x-diff; charset=us-ascii; name=patch-2.6.0-test1_bug939
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=patch-2.6.0-test1_bug939

--- linux-2.6.0-test1-vanilla/arch/h8300/README	2003-07-13 23:36:33.000000000 -0400
+++ linux-2.6.0-test1-eva/arch/h8300/README	2003-07-17 02:03:21.000000000 -0400
@@ -16,7 +16,7 @@
 
 3.H8MAX 
   Under development
-  see http://www.strawbelly-linux.com (Japanese Only)
+  see http://www.strawberry-linux.com (Japanese Only)
 
 * Toolchain Version
 gcc-3.1 or higher and patch

--Boundary_(ID_eqe4UPslvPyAg3yjolnlcQ)--
