Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267535AbSKQR60>; Sun, 17 Nov 2002 12:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267540AbSKQR60>; Sun, 17 Nov 2002 12:58:26 -0500
Received: from adsl-65-66-148-247.dsl.kscymo.swbell.net ([65.66.148.247]:23940
	"EHLO hofmann1.gchofmann.org") by vger.kernel.org with ESMTP
	id <S267535AbSKQR6Z>; Sun, 17 Nov 2002 12:58:25 -0500
Subject: 2.5.47-ac5 compile failure: missing linux/iobuf.h
From: "Glenn C. Hofmann" <ghofmann@pair.com>
To: linux-kernel@vger.kernel.org
Cc: Simon Evans <spse@secret.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mZm+yYsEkkt39BoozjS9"
Organization: 
Message-Id: <1037556071.12239.13.camel@hofmann1.gchofmann.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 17 Nov 2002 12:05:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mZm+yYsEkkt39BoozjS9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

While trying to compile blkmtd.c it cannot find linux/iobuf.h.  This is
due to the fact that it isn't there.  Searching the lkml archives, there
is no mention of this file being removed nor of anybody else having this
issue, that I can find.

Chris

--=-mZm+yYsEkkt39BoozjS9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA919lnkPlrlFLq0bIRAo9CAKC95f7T5glwD1pStCC23taAhgjMuACaA/WZ
yQ2uxRY8FNNq57WUkUn1ZHo=
=dFSI
-----END PGP SIGNATURE-----

--=-mZm+yYsEkkt39BoozjS9--
