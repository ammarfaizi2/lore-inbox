Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318697AbSG0FNf>; Sat, 27 Jul 2002 01:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318698AbSG0FNf>; Sat, 27 Jul 2002 01:13:35 -0400
Received: from dsl-64-192-31-41.telocity.com ([64.192.31.41]:10624 "EHLO
	butterfly.hjsoft.com") by vger.kernel.org with ESMTP
	id <S318697AbSG0FNe>; Sat, 27 Jul 2002 01:13:34 -0400
From: glynis@butterfly.hjsoft.com
Date: Sat, 27 Jul 2002 01:16:49 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.29: acpi compile error
Message-ID: <20020727051649.GA11560@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

drivers/acpi/system.c is missing an #include <linux/interrupt.h>
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9QizBCGPRljI8080RAmAJAJ9kG3GT93ddGntCMpEtsqWLDL93tACfeFyK
NINAiJcu0Ukly1Q0bLKrAsg=
=y70J
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
