Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSJaTs4>; Thu, 31 Oct 2002 14:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263249AbSJaTs4>; Thu, 31 Oct 2002 14:48:56 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:16751 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S263246AbSJaTsy>;
	Thu, 31 Oct 2002 14:48:54 -0500
Date: Thu, 31 Oct 2002 20:55:14 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031205514.C12469@jaquet.dk>
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031092440.B5815@jaquet.dk> <1036092802.7799.2.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1036092802.7799.2.camel@sonja.de.interearth.com>; from degger@fhm.edu on Thu, Oct 31, 2002 at 08:33:21PM +0100
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2002 at 08:33:21PM +0100, Daniel Egger wrote:
> Am Don, 2002-10-31 um 09.24 schrieb Rasmus Andersen:
>=20
> > I tried -Os once, and it didn't boot for me. So I dumped it.
> > However, reading a mail from Zwane <somethingorother> about
> > booting 2.5.x on a 4MB system I got the impression that he
> > used Os, so I might give it another shot. Dropping down to
> > i386 support, perhaps.
>=20
> If you meant removing special support for faster processors this might
> be a gain, if it was something along the lines of "-mcpu=3Di386
> -mtune=3Di386" this would be pretty sure a loss resulting in bigger code.

I was just wondering aloud if my boot problem would go away if
I did -Os and -mcpu=3D386. Just a wonder, though.

Regards,
  Rasmus

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9wYqilZJASZ6eJs4RAgpMAKCH5Lq/7Tv85FQi6nohcdm2VcV2bQCfUwT4
O0Iv/GjpNz8EZ/HP36dT9D0=
=cQU5
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
