Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267410AbTAGP4D>; Tue, 7 Jan 2003 10:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267411AbTAGP4D>; Tue, 7 Jan 2003 10:56:03 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:3296
	"EHLO localhost") by vger.kernel.org with ESMTP id <S267410AbTAGP4A>;
	Tue, 7 Jan 2003 10:56:00 -0500
Date: Tue, 7 Jan 2003 08:04:16 -0800
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-ck2 and some game timings
Message-ID: <20030107160416.GA15405@kanoe.ludicrus.net>
References: <20030106193730.GA22289@kanoe.ludicrus.net> <200301072237.27766.conman@kolivas.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <200301072237.27766.conman@kolivas.net>
User-Agent: Mutt/1.5.3i
From: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Was it changed at any other points in the Linux kernel? I've been always
playing zblast everytime i am waiting for a kernel to compile, since the ta=
ilend
of 2.3 :)

Regards
Josh

On Tue, Jan 07, 2003 at 10:37:23PM +1100, Con Kolivas wrote:
> On Tuesday 07 Jan 2003 6:37 am, you wrote:
> > This was a while ago... But when I upgraded to kernel 2.4.20-ck2, I
> > tried to play ZBlast (www.svgalib.org/rus/zblast) in both console
> > (svgalib) and X mode and the game seemed to be running in double time!
> > Is this a timing problem within the code or a quirk in the low latency
> > routines of the -ck2 patch? When useing a vanilla 2.4.20 kernel there is
> > nothing wrong.
> >
> > Has anyone else noticed this?
>=20
> Nope, you're the first. There is one thing that could explain it though, =
and=20
> that is the increased timer interrupt frequency in -ck2 from 100 to 1000H=
z.=20
> Perhaps something in that game is based on the interrupt frequency. For a=
ll=20
> other things there is no reason any timer should go haywire.
>=20
> Con

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+GvqA6TRUxq22Mx4RAlciAJ9hx6rK2cVT2NIULhujqV5MAWX+dACgqH/Y
p7HjepTKVgjxZDdclWbFsck=
=cQIQ
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
