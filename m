Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263323AbSITTWy>; Fri, 20 Sep 2002 15:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSITTWy>; Fri, 20 Sep 2002 15:22:54 -0400
Received: from [216.38.156.94] ([216.38.156.94]:38407 "EHLO
	mail.networkfab.com") by vger.kernel.org with ESMTP
	id <S263323AbSITTWx>; Fri, 20 Sep 2002 15:22:53 -0400
Subject: Re: USB - scanner - devel
From: Dmitri <dmitri@users.sourceforge.net>
To: "Yann E. MORIN" <yann.morin.1998@anciens.enib.fr>
Cc: sane-devel@www.mostang.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020920184530.84F7F6511A@mallaury.noc.nerim.net>
References: <20020920184530.84F7F6511A@mallaury.noc.nerim.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iN4whEiyzr2YVN1ayJyD"
Organization: 
Message-Id: <1032550079.13913.51.camel@usb.networkfab.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 20 Sep 2002 12:27:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iN4whEiyzr2YVN1ayJyD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-09-20 at 11:45, Yann E. MORIN wrote:

> I've just had a brand new Canon CanoScan N676U. I hope it works great as =
it
> is not yet supported by Sane. That's why I volunteer to add support for t=
his
> device in Sane.
>=20
> Could someone please point me to documents / source code / URLs / RFC /
> whatever is of interest to start coding a new backend for sane and to
> understand USB programming (kernel Guys, ideas?) ?

A generic USB scanner driver is already available. It might work for
you; then all you need is to add SANE backend (or to hack an existing
one). If the USB driver works (it is simple) then you don't need to know
anything about USB.

The USB development mailing list can be found at
http://www.linux-usb.org/

Dmitri


--=-iN4whEiyzr2YVN1ayJyD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9i3a/XksyLpO6T4IRAlF3AJ9Nb43gdo7g8q3VlsKd5X124xDRDgCfawhH
623DhJeOP6WGccBRVfH8tzE=
=kara
-----END PGP SIGNATURE-----

--=-iN4whEiyzr2YVN1ayJyD--

