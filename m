Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264686AbUFSVNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264686AbUFSVNM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 17:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUFSVNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 17:13:11 -0400
Received: from wblv-235-33.telkomadsl.co.za ([165.165.235.33]:43445 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264686AbUFSVNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 17:13:06 -0400
Subject: Re: Stop the Linux kernel madness
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>,
       Sam Ravnborg <sam@ravnborg.org>,
       4Front Technologies <dev@opensound.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406191952520.10292@scrub.local>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay>
	 <40D23701.1030302@opensound.com> <20040618204655.GA4441@mars.ravnborg.org>
	 <40D46B97.B82A439E@users.sourceforge.net>
	 <Pine.LNX.4.58.0406191952520.10292@scrub.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6A3w3uxqRnATN6GSMzvW"
Message-Id: <1087679544.14905.106.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 19 Jun 2004 23:12:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6A3w3uxqRnATN6GSMzvW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-19 at 20:01, Roman Zippel wrote:
> Hi,
>=20
> On Sat, 19 Jun 2004, Jari Ruusu wrote:
>=20
> > > So you seems to be bitten by a distributor starting to use a new
> > > facility in kbuild.
> >=20
> > SUSE folks made a silly mistake and broke stuff. It was even more silly=
 for
> > them to try to submit that breakage to mainline.
>=20
> Letting the symlink point to the build directory is the only sane option.=
=20
> What's missing is that the native kernel tree itself should generate a=20
> small Makefile in the build directory.
> SuSE did the right thing, it now just needs proper integration.
>=20

The point is that many things will break.  Sure, I speak partly out of
the point of view of somebody who now and then do some distro work, but
also thinking about all those out there who might compile by hand.

I can see that how they want to do it might be more logical, but please
with sugar on, do not do it in 2.6.


Thanks.

--=20
Martin Schlemmer

--=-6A3w3uxqRnATN6GSMzvW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1Kw4qburzKaJYLYRAnBqAJ0eYE5ZiaI+7UJQKLpS5xDLmmnXggCeNivZ
35FBy20q0lLouxeQ5LhlhbA=
=4OJN
-----END PGP SIGNATURE-----

--=-6A3w3uxqRnATN6GSMzvW--

