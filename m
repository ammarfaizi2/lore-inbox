Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317230AbSHBVVQ>; Fri, 2 Aug 2002 17:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSHBVVQ>; Fri, 2 Aug 2002 17:21:16 -0400
Received: from factorix.sdv.fr ([212.95.66.10]:65413 "EHLO factorix.sdv.fr")
	by vger.kernel.org with ESMTP id <S317230AbSHBVVQ>;
	Fri, 2 Aug 2002 17:21:16 -0400
Date: Sat, 3 Aug 2002 01:29:44 +0200
To: linux-kernel@vger.kernel.org
Subject: Little bug in the 2.5.9 release
Message-ID: <20020802232944.GA11386@piaf.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Olivier Beau <piaf@evc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There is a duplicate definition in init/main.c at the lines 275 and 279.

Hopping it may help,=20

Olivier.
--=20

+-----------------------------------+
| Olivier Beau, piaf <piaf@evc.net> |
+-----------------------------------+


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9SxXktoV0jY7C9HMRAuj3AKDIyfUE1z7Zr6mlauhF9y58KmmVBwCgij5P
0yKzBi5IFDQEtVZxVdS63JE=
=0SvA
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
