Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312939AbSDYGYd>; Thu, 25 Apr 2002 02:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312942AbSDYGYc>; Thu, 25 Apr 2002 02:24:32 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:12297 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S312939AbSDYGYc>;
	Thu, 25 Apr 2002 02:24:32 -0400
Date: Thu, 25 Apr 2002 10:28:59 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Malcolm Mallardi <magamo@ranka.2y.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre7 MIPS compile errors.
Message-ID: <20020425062859.GA2418@pazke.ipt>
Mail-Followup-To: Malcolm Mallardi <magamo@ranka.2y.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020424145825.A21701@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Malcolm,

for the second problem did you try to add #include <linux/personality.h>=20
line in signal.c ?

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8x6IrBm4rlNOo3YgRAt7rAJwKm+torDR9w83njyZZY6yGB+gkuACfbEmm
YPR0D8jUf8Rgj9ESEGIUMUw=
=p/OG
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
