Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265213AbSJaITa>; Thu, 31 Oct 2002 03:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264827AbSJaITa>; Thu, 31 Oct 2002 03:19:30 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:22883 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S265219AbSJaISV>;
	Thu, 31 Oct 2002 03:18:21 -0500
Date: Thu, 31 Oct 2002 09:24:40 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031092440.B5815@jaquet.dk>
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Thu, Oct 31, 2002 at 01:53:14AM +0100
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2002 at 01:53:14AM +0100, Adrian Bunk wrote:

Hi Adrian,
>=20
> could you try to use "-Os" instead of "-O2" as gcc optimization option
> when CONFIG_TINY is enabled? Something like the following (completely
> untested) patch:

I tried -Os once, and it didn't boot for me. So I dumped it.
However, reading a mail from Zwane <somethingorother> about
booting 2.5.x on a 4MB system I got the impression that he
used Os, so I might give it another shot. Dropping down to
i386 support, perhaps.

Thanks for reading,
  Rasmus

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9wOjHlZJASZ6eJs4RAvzNAJ4lYl35ymoCa9ptrbRnCQCLfUCZTACgg+LH
1qzJsxmRGM51XbwqLmW/Puk=
=xt4w
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
