Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSHOMRV>; Thu, 15 Aug 2002 08:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSHOMRV>; Thu, 15 Aug 2002 08:17:21 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:33475 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S316842AbSHOMRU>; Thu, 15 Aug 2002 08:17:20 -0400
Date: Thu, 15 Aug 2002 15:16:02 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sound choking with trident driver (SiS 7018)
Message-ID: <20020815121602.GI6772@alhambra.actcom.co.il>
References: <1029409909.1121.17.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D6z0c4W1rkZNF4Vu"
Content-Disposition: inline
In-Reply-To: <1029409909.1121.17.camel@paragon.slim>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2002 at 01:11:49PM +0200, Jurgen Kramer wrote:
> Hi,
>=20
> I have a laptop with a SiS 7018 soundchip. While playing music
> the sound chokes every few seconds (2.4.19 kernel). I am not sure where
> the problem lies. With the ALSA drivers under kernel 2.5 the problem is
> not there.
>=20
> Is there a newer driver for the SiS 7018 (trident.c). The current driver
> in 2.4 is dated October 2001.

the -ac tree and 2.4.20-pre1 and onwards (as well as 2.5) contain an
updated trident.c driver. I don't see anything there that is obviously
related to your problems, but you might wish to give the updated
driver a try anyway. =20

Thanks and please let us know how it goes,=20
--=20
"Hmm.. Cache shrink failed - time to kill something?
 Mhwahahhaha! This is the part I really like. Giggle."
					 -- linux/mm/vmscan.c
http://vipe.technion.ac.il/~mulix/	http://syscalltrack.sf.net

--D6z0c4W1rkZNF4Vu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9W5uBKRs727/VN8sRAourAJwJ9GZCQFFcKNNAeErr5rkVHldnZACcCuJq
Z+K9SMsPGO+OtmK3IsJmPPw=
=gKd9
-----END PGP SIGNATURE-----

--D6z0c4W1rkZNF4Vu--
