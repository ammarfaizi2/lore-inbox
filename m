Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWBFUAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWBFUAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWBFUAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:00:22 -0500
Received: from mx.laposte.net ([81.255.54.11]:45026 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S932345AbWBFUAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:00:20 -0500
Subject: Re: Linux drivers management
From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Joshua Kugler <joshua.kugler@uaf.edu>, linux-kernel@vger.kernel.org,
       David Chow <davidchow@shaolinmicro.com>
In-Reply-To: <Pine.LNX.4.61.0602061420400.17351@chaos.analogic.com>
References: <1139250712.20009.20.camel@rousalka.dyndns.org>
	 <200602061002.27477.joshua.kugler@uaf.edu>
	 <Pine.LNX.4.61.0602061420400.17351@chaos.analogic.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/nh/nkL/eOPxYGbBtkUu"
Organization: Adresse perso
Date: Mon, 06 Feb 2006 20:58:58 +0100
Message-Id: <1139255939.20009.46.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/nh/nkL/eOPxYGbBtkUu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le lundi 06 f=C3=A9vrier 2006 =C3=A0 14:21 -0500, linux-os (Dick Johnson) a
=C3=A9crit :

> Right now, there are really too many drivers in the kernel.
> The kernel should have a stable API for drivers and they
> should be in a separate tree, either on the Web or on a
> distribution disc. There are many drivers that are as old
> as Linux! The 3c501.c and 3c503.c are examples. You can't
> remove them from the kernel without invoking a thousand
> angry responses. These boards and the ne*.c network boards
> just won't go away!

This is another proof in-kernel maintenance is cheaper.
If out-of-tree drivers where lower maintenance like it's claimed, they'd
have a lower attrition rate than in-kernel stuff.

--=20
Nicolas Mailhot

--=-/nh/nkL/eOPxYGbBtkUu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEABECAAYFAkPnqoAACgkQI2bVKDsp8g2cFwCglI2aan7oXBdMnyhPQjB1GkOA
pqQAn39wovDMzMzpLrmjVtUPgwjsFGyU
=u1+1
-----END PGP SIGNATURE-----

--=-/nh/nkL/eOPxYGbBtkUu--

