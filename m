Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVA0Slu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVA0Slu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVA0Slu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:41:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:37768 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262611AbVA0Sl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:41:29 -0500
X-Authenticated: #641082
Subject: patches to 2.6.9 and 2.6.10 - make menuconfig shows "v2.6.8.1"
From: Viktor Horvath <ViktorHorvath@gmx.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-afqvtEVJQrhjuHwi9uHA"
Date: Thu, 27 Jan 2005 19:40:54 +0100
Message-Id: <1106851254.720.4.camel@Charon>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-afqvtEVJQrhjuHwi9uHA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello everybody,

today I patched myself up from 2.6.7 vanilla to 2.6.10 vanilla, but
after all patches succeeded, "make menuconfig" shows "v2.6.8.1
Configuration". Even worse, a compiled kernel calls in his bootlog
himself "2.6.8.1". When installing the whole kernel package, this
behaviour doesn't show up.

Sorry if this is a dumb question, but I could not find an answer in the
archives.

Have a nice day,
Viktor.

Please Cc: me when answering.

--=-afqvtEVJQrhjuHwi9uHA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB+TW2O3SWVYLvaJQRAtIgAJ0Tt4svg1ngKgk1qdvd0pPxBQ575wCcCrtT
KGh8EMzUyD/7BusKoGa10vQ=
=jEsV
-----END PGP SIGNATURE-----

--=-afqvtEVJQrhjuHwi9uHA--

