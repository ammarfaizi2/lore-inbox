Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTITKDh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 06:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTITKDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 06:03:37 -0400
Received: from 4demon.com ([217.160.186.4]:21142 "EHLO pro-linux.de")
	by vger.kernel.org with ESMTP id S261773AbTITKDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 06:03:35 -0400
Date: Sat, 20 Sep 2003 12:03:32 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Cc: Claus-Justus Heine <heine@instmath.rwth-aachen.de>,
       marcelo.tosatti@cyclades.com.br
Subject: ftape new web address
Message-ID: <20030920100331.GO9599@kiwi.hjbaader.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0fZkDq/H4AmqaB8D"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0fZkDq/H4AmqaB8D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the attached patch for 2.4.22 fixes the web address of the ftape driver.
Why does the kernel still contain version 3.0.4 when 4.0.4a is the
current one?

It should apply for kernel 2.6, too.

Regards,
hjb


diff -ur linux-2.4.22.orig/Documentation/ftape.txt linux-2.4.22/Documentati=
on/ftape.txt
--- linux-2.4.22.orig/Documentation/ftape.txt	1999-11-06 19:38:40.000000000=
 +0100
+++ linux-2.4.22/Documentation/ftape.txt	2003-09-20 11:43:09.000000000 +0200
@@ -15,7 +15,7 @@
=20
 ftape has a home page at
=20
-http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape
+http://www.instmath.rwth-aachen.de/~heine/ftape/
=20
 which contains further information about ftape. Please cross check
 this WWW address against the address given (if any) in the MAINTAINERS
@@ -58,7 +58,7 @@
 versions of ftape and useful links to related topics can be found at
 the ftape home page at
=20
-http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape
+http://www.instmath.rwth-aachen.de/~heine/ftape/
=20
 **************************************************************************=
*****
=20
@@ -132,7 +132,7 @@
=20
    or from the ftape home page at
=20
-   http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape
+   http://www.instmath.rwth-aachen.de/~heine/ftape/
=20
    `ftformat' is contained in the `./contrib/' subdirectory of that
    separate ftape package.
diff -ur linux-2.4.22.orig/MAINTAINERS linux-2.4.22/MAINTAINERS
--- linux-2.4.22.orig/MAINTAINERS	2003-09-07 17:41:30.000000000 +0200
+++ linux-2.4.22/MAINTAINERS	2003-09-20 11:57:59.000000000 +0200
@@ -722,9 +722,9 @@
=20
 FTAPE/QIC-117
 P:	Claus-Justus Heine
-M:	claus@momo.math.rwth-aachen.de
+M:	heine@instmath.rwth-aachen.de
 L:	linux-tape@vger.kernel.org
-W:	http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape/
+W:	http://www.instmath.rwth-aachen.de/~heine/ftape/
 S:	Maintained
=20
 FUTURE DOMAIN TMC-16x0 SCSI DRIVER (16-bit)

--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--0fZkDq/H4AmqaB8D
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/bCXzLbySPj3b3eoRAkX4AJ4tZ4byuWHySc39MNL1z0qvHHfiEgCfa0eM
tfwBVzMU9P2Dv7jGoUuv/u0=
=igsB
-----END PGP SIGNATURE-----

--0fZkDq/H4AmqaB8D--
