Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVB0AVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVB0AVm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVB0ATY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:19:24 -0500
Received: from resin.csoft.net ([63.111.22.86]:20787 "HELO mail231.csoft.net")
	by vger.kernel.org with SMTP id S261308AbVB0ASJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:18:09 -0500
Subject: 2.4.29-lck1
From: Eric Hustvedt <lkml@plumlocosoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-z2gQ+C2cLuwyUkK/RHa6"
Date: Sat, 26 Feb 2005 19:18:04 -0500
Message-Id: <1109463485.21552.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-z2gQ+C2cLuwyUkK/RHa6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Updated the lck patchset. This is the patchset formerly known as the
2.4-ck patchset.

http://www.plumlocosoft.com/kernel/

Includes:
O(1) scheduler with batch scheduling, interactivity
Preemptible kernel
Low Latency
Read Latency2
Variable Hz
64-bit jiffies
Supermount-NG v1.2.11a
Bootsplash v3.0.7
POSIX ACL/xattr v0.8.71
POSIX extended security attributes v0.8.71
NTFS file system v2.1.6b

Updated:
- GCC 3.4 compile fixes. Thanks to Daniel Drake and Benigno Junior

Pending:
- GRsec update to version 2.1.1.

--=20
Eric Hustvedt <lkml@plumlocosoft.com>

--=-z2gQ+C2cLuwyUkK/RHa6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCIRG88O0ZDXGTPEIRAqZ/AJ915nAt0WTrzp11sDmtp6utunLZsQCfd24f
LAnajG7yKqsD99NV74W0RC0=
=eN69
-----END PGP SIGNATURE-----

--=-z2gQ+C2cLuwyUkK/RHa6--

