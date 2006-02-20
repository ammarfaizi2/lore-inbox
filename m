Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbWBTWXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWBTWXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932666AbWBTWXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:23:08 -0500
Received: from ctb-mesg8.saix.net ([196.25.240.78]:61614 "EHLO
	ctb-mesg8.saix.net") by vger.kernel.org with ESMTP id S932629AbWBTWXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:23:05 -0500
Subject: Re: kernel panic with unloadable module support... SMP
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: George P Nychis <gnychis@cmu.edu>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <55990.128.237.252.29.1140472824.squirrel@128.237.252.29>
References: <1174.128.237.252.29.1140376277.squirrel@128.237.252.29>
	 <20060219191552.GB4971@stusta.de> <1140472618.29789.12.camel@lycan.lan>
	 <55990.128.237.252.29.1140472824.squirrel@128.237.252.29>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-USHPCtwLZupdERccXzU+"
Date: Tue, 21 Feb 2006 00:25:38 +0200
Message-Id: <1140474339.29789.28.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-USHPCtwLZupdERccXzU+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-02-20 at 17:00 -0500, George P Nychis wrote:
> actually, what I am stating is correct, and yes there is 2.6.15-r_ in por=
tage for vanilla-sources:
>=20
> monster hedpe # emerge -pv vanilla-sources
>=20
> These are the packages that I would merge, in order:
>=20
> Calculating dependencies ...done!
> [ebuild   R   ] sys-kernel/vanilla-sources-2.6.15.1  -build -doc -symlink=
 0 kB=20
>=20
> Total size of downloads: 0 kB
>=20
> That is using ~x86 keyword.
>=20

Yup, but its .1 not -r1 ... the official 'stable patch release' or
whatever its officially called done by Greg KH and somebody else.  Point
was that it is vanilla sources, and no real reason for them to tell you
to use vanilla sources, except maybe try a newer version to see if its
fixed already.

Hope that helps.


Regards,

> - George
>=20
>=20
> > On Sun, 2006-02-19 at 20:15 +0100, Adrian Bunk wrote:
> >> On Sun, Feb 19, 2006 at 02:11:17PM -0500, George P Nychis wrote:
> >>=20
> >>> Hi,
> >>=20
> >> Hi George,
> >>=20
> >>> Whenever I compiled unloadable module support into my 2.6.15-r1
> >>> kernel, my kernel panic's when booting up when it tries to load a
> >>> module for the first time.
> >>>=20
> >>> I had this problem back with the 2.6.14 kernel, but figured it may
> >>> have been solved since then so I tried it... and still fails.
> >>>=20
> >>> Unloadable module support would be very helpful to me.
> >>>=20
> >>> I am using an intel p4 3.0ghz with SMP support built into the kernel.
> >>>  ...
> >>=20
> >> What is 2.6.15-r1 for a kernel? Is your problem present in an unmodifi=
ed
> >> 2.6.16-rc4 kernel from ftp.kernel.org?
> >>=20
> >=20
> > If it was gentoo's vanilla-sources (which is just that - vanilla=20
> > kernel.org sources), then no 2.6.x version ever packaged by Gentoo, so=20
> > either he had gentoo-sources, which is something totally different (and=
=20
> > not vanilla sources as he specified), or there is a naming issue ...
> >=20
> >=20
> > Regards,
> >=20
> > -- Martin Schlemmer
> >=20
> >=20
>=20
>=20
--=20
Martin Schlemmer


--=-USHPCtwLZupdERccXzU+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQBD+kHiqburzKaJYLYRAoveAJwJeQIFgeKKWxVtW7Ym48ZSqywE+ACeNNp1
x+LsrkR//C4efXPCucm9MIk=
=PW4i
-----END PGP SIGNATURE-----

--=-USHPCtwLZupdERccXzU+--

