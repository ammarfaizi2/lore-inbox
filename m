Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUHSJWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUHSJWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUHSJWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:22:43 -0400
Received: from chico.rediris.es ([130.206.1.3]:42437 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S264419AbUHSJLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:11:14 -0400
From: David Martinez Moreno - RedIRIS <david.martinez@rediris.es>
Organization: Red.es/RedIRIS
To: linux-kernel@vger.kernel.org, akpm@osdl.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] Update ftape webpage
Date: Thu, 19 Aug 2004 11:11:44 +0200
User-Agent: KMail/1.6.2
Cc: =?iso-8859-15?q?Ram=F3n_Rey_Vicente?= <ramon.rey@hispalinux.es>
References: <4123F54E.4090900@hispalinux.es>
In-Reply-To: <4123F54E.4090900@hispalinux.es>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Q7GJB/TQsh1KGnP"
Message-Id: <200408191111.45187.david.martinez@rediris.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Q7GJB/TQsh1KGnP
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

	Hello, Andy and Marcelo.

	Please apply, it is for both trees, Ram=F3n did not update the=20
Documentation/ftape.txt.

	Marcelo, I think that Ram=F3n's previous patch apply cleanly (with a lot o=
f=20
offset) to 2.4, so please apply as well.

	Thanks,


		Ender.
=2D --=20
We accidentally replaced your heart with a baked potato. You have
 about three seconds to live.
 		-- Dr. Doctor to Kenny (South Park).
=2D --
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Red.es - Madrid (Spain)
Tlf (+34) 91.212.76.25
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBJG7QWs/EhA1iABsRAnjYAJ4//38Jw0Q5O+7w3gRGBs+vVgT06ACgmxKo
qqNTte0AMeEd3Km5zNwXlW0=3D
=3DnIil
=2D----END PGP SIGNATURE-----

--Boundary-00=_Q7GJB/TQsh1KGnP
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="ftape.txt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ftape.txt.patch"

--- tmp/Documentation/ftape.txt.orig	2004-08-19 11:02:09.000000000 +0200
+++ tmp/Documentation/ftape.txt	2004-08-19 11:04:14.000000000 +0200
@@ -15,7 +15,7 @@
 
 ftape has a home page at
 
-http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape
+http://www.instmath.rwth-aachen.de/~heine/ftape/
 
 which contains further information about ftape. Please cross check
 this WWW address against the address given (if any) in the MAINTAINERS
@@ -58,7 +58,7 @@
 versions of ftape and useful links to related topics can be found at
 the ftape home page at
 
-http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape
+http://www.instmath.rwth-aachen.de/~heine/ftape/
 
 *******************************************************************************
 
@@ -132,7 +132,7 @@
 
    or from the ftape home page at
 
-   http://www-math.math.rwth-aachen.de/~LBFM/claus/ftape
+   http://www.instmath.rwth-aachen.de/~heine/ftape/
 
    `ftformat' is contained in the `./contrib/' subdirectory of that
    separate ftape package.

--Boundary-00=_Q7GJB/TQsh1KGnP--
