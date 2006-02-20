Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbWBTVyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWBTVyf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWBTVyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:54:35 -0500
Received: from ctb-mesg5.saix.net ([196.25.240.75]:4003 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S932623AbWBTVyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:54:35 -0500
Subject: Re: kernel panic with unloadable module support... SMP
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Adrian Bunk <bunk@stusta.de>
Cc: George P Nychis <gnychis@cmu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060219191552.GB4971@stusta.de>
References: <1174.128.237.252.29.1140376277.squirrel@128.237.252.29>
	 <20060219191552.GB4971@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MAmXFff5IOREQgX27hJk"
Date: Mon, 20 Feb 2006 23:56:58 +0200
Message-Id: <1140472618.29789.12.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MAmXFff5IOREQgX27hJk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-02-19 at 20:15 +0100, Adrian Bunk wrote:
> On Sun, Feb 19, 2006 at 02:11:17PM -0500, George P Nychis wrote:
>=20
> > Hi,
>=20
> Hi George,
>=20
> > Whenever I compiled unloadable module support into my 2.6.15-r1 kernel,=
 my kernel panic's when booting up when it tries to load a module for the f=
irst time.
> >=20
> > I had this problem back with the 2.6.14 kernel, but figured it may have=
 been solved since then so I tried it... and still fails.
> >=20
> > Unloadable module support would be very helpful to me.
> >=20
> > I am using an intel p4 3.0ghz with SMP support built into the kernel.
> >...
>=20
> What is 2.6.15-r1 for a kernel?
> Is your problem present in an unmodified 2.6.16-rc4 kernel from=20
> ftp.kernel.org?
>=20

If it was gentoo's vanilla-sources (which is just that - vanilla
kernel.org sources), then no 2.6.x version ever packaged by Gentoo, so
either he had gentoo-sources, which is something totally different (and
not vanilla sources as he specified), or there is a naming issue ...


Regards,

--=20
Martin Schlemmer


--=-MAmXFff5IOREQgX27hJk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBD+jsqqburzKaJYLYRArLXAJ47Q4j+0B6DZ7JKLPTyqXxlmsiKIgCglDEf
4k3t4Y4bNsaVW19930Irenc=
=zSn0
-----END PGP SIGNATURE-----

--=-MAmXFff5IOREQgX27hJk--

