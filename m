Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130075AbQLMEjk>; Tue, 12 Dec 2000 23:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130779AbQLMEj3>; Tue, 12 Dec 2000 23:39:29 -0500
Received: from ziggy.one-eyed-alien.net ([216.51.112.145]:46860 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S130075AbQLMEjL>; Tue, 12 Dec 2000 23:39:11 -0500
Date: Tue, 12 Dec 2000 20:08:40 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Frédéric L . W . Meunier 
	<0@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mass storage backport status?
Message-ID: <20001212200840.K23762@one-eyed-alien.net>
Mail-Followup-To: Frédéric L . W . Meunier <0@pervalidus.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001213014154.H1245@pervalidus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001213014154.H1245@pervalidus>; from 0@pervalidus.net on Wed, Dec 13, 2000 at 01:41:54AM -0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2000 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Depending on the type of device you have and how you use it, it can either:
(1) Work properly
(2) Corrupt your data
(3) Crash the driver
(4) Crash your system

It's allready labeled EXPERIMENTAL.  Perhaps it should be labeled
DANGEROUS, also, but how many labels can you put on things to warn people
off?

Matt Dharm

On Wed, Dec 13, 2000 at 01:41:54AM -0200, Fr=E9d=E9ric L . W . Meunier wrot=
e:
> What's the real status of the mass storage backport to 2.2.18?
> Some people report it can corrupt your data, another that it
> rebooted his computer while doing a large trasnfer, and so on.
>=20
> If it's not good, shouldn't it be removed or labeled
> DANGEROUS? BTW, where can I see a list of what's backported
> and working without major problems?
>=20
> --=20
> 0@pervalidus.{net,{dyndns.}org} TelFax: 55-21-717-2399 (Niter=F3i-RJ BR)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Umm, these aren't the droids you're looking for.
					-- Bill Gates
User Friendly, 11/14/1998

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6NvZIz64nssGU+ykRAmB+AKCs6F1rIeAGj28Elzq6yHd6cUku8ACbBzKA
w/vvPdskV6dl/vemqjXUFyI=
=0UQX
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
