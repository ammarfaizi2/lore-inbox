Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbSLNUBN>; Sat, 14 Dec 2002 15:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbSLNUBN>; Sat, 14 Dec 2002 15:01:13 -0500
Received: from adsl-65-64-152-167.dsl.stlsmo.swbell.net ([65.64.152.167]:18305
	"EHLO base.torri.linux") by vger.kernel.org with ESMTP
	id <S265857AbSLNUBM>; Sat, 14 Dec 2002 15:01:12 -0500
Subject: Unresolved symbols in agpart
From: Stephen Torri <storri@sbcglobal.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-b1VUsfiIydGrtemqqkHz"
Organization: 
Message-Id: <1039896536.963.7.camel@base.torri.linux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 14 Dec 2002 14:08:56 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b1VUsfiIydGrtemqqkHz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I would like to help clear up the module problem in the linux kernel
(2.5.51). The problem I am getting is when I do "make install" there is
a report back that some symbols are unresolved. What I need to know is
how these symbols are supposed to be exported? I can grep the files to
find the symbols and correct this problem.

Stephen
--=20
Stephen Torri <storri@sbcglobal.net>

--=-b1VUsfiIydGrtemqqkHz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9+4/YsZ6ZpmJVIPURAqo1AKCC5WK64Essn2uFpMvC9SDs22iiMQCfXnA/
gknJpshrdnYgAgUZ5Nw6yaw=
=UM3/
-----END PGP SIGNATURE-----

--=-b1VUsfiIydGrtemqqkHz--
