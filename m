Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262687AbTCJBa1>; Sun, 9 Mar 2003 20:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262689AbTCJBa1>; Sun, 9 Mar 2003 20:30:27 -0500
Received: from B503f.pppool.de ([213.7.80.63]:3010 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S262687AbTCJBa0>; Sun, 9 Mar 2003 20:30:26 -0500
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
From: Daniel Egger <degger@fhm.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <b4gnf1$n6f$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
	 <1047209545.4102.3.camel@sonja> <m1adg4kbjn.fsf@frodo.biederman.org>
	 <1047219550.4102.6.camel@sonja>  <b4gnf1$n6f$1@cesium.transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7wub2bUtEEdPYdoulnB1"
Organization: 
Message-Id: <1047260440.14971.16.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 10 Mar 2003 02:40:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7wub2bUtEEdPYdoulnB1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mon, 2003-03-10 um 01.49 schrieb H. Peter Anvin:

> Try pxelinux... it doesn't need any kind of tagging.

Unfortunately I couldn't get it to work when I tried last
time and now I've too many machines running on the good ol'
double hit tftp scheme to make a switch quite cumbersome.

But you're right, I should definitely try it. I've two questions
regarding it though:
- Right now I've several machines having etherboot on flash, how
  can I use pxelinux (or similar) with them? I don't want to have
  two quite different ways to deal with.
- Are there any kind of constraints which annoy me right now
  with etherboot/mknbi like maximum kernel size < 1M?

--=20
Servus,
       Daniel


--=-7wub2bUtEEdPYdoulnB1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+a+0Xchlzsq9KoIYRAv/iAJ0X2BSxGM+wcpcBp9Wyt/h/qgd18QCgiw6B
HwyfcB7yehGKeZpj2ddSqh4=
=2WHQ
-----END PGP SIGNATURE-----

--=-7wub2bUtEEdPYdoulnB1--

