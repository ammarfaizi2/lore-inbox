Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262743AbVAVVMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbVAVVMO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 16:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbVAVVJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 16:09:17 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:36529 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262743AbVAVVF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 16:05:56 -0500
Subject: Re: Linux 2.6.11-rc2
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050122125759.7d597594@laptop.hypervisor.org>
References: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
	 <20050121223247.65c544f8@laptop.hypervisor.org>
	 <1106402669.20995.23.camel@tux.rsn.bth.se>
	 <20050122125759.7d597594@laptop.hypervisor.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Rzqqt4h/w/NO+sJtr1ZN"
Date: Sat, 22 Jan 2005 22:05:52 +0100
Message-Id: <1106427952.20995.32.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Rzqqt4h/w/NO+sJtr1ZN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-01-22 at 12:57 -0800, Udo A. Steinberg wrote:
> On Sat, 22 Jan 2005 15:04:29 +0100 Martin Josefsson (MJ) wrote:
>=20
> MJ> On Fri, 2005-01-21 at 22:32 -0800, Udo A. Steinberg wrote:
> MJ> >=20
> MJ> > Connection tracking does not compile...
>=20
> MJ> The problem is when compiling without NAT...
> MJ> The patch below should fix it, I can compile both with and without NA=
T
> MJ> now.
>=20
> Thanks, this fixes my problem, too.

Great.

> Linus, please apply the following patch from Martin.

It should trickle in to Linus tree through davem pretty soon I hope,
together with some other bugfixes (fix for SNAT/DNAT not working at all
on parisc and possibly other architectures)

--=20
/Martin

--=-Rzqqt4h/w/NO+sJtr1ZN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB8sAwWm2vlfa207ERAsGIAJ9FUFomN5mrrYzufNvAZWlOdJ5a4wCgu8GZ
37Xps+z0MvlrZsY/hYTDF9o=
=TIuw
-----END PGP SIGNATURE-----

--=-Rzqqt4h/w/NO+sJtr1ZN--
