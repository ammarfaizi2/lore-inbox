Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271906AbRIDIfl>; Tue, 4 Sep 2001 04:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271910AbRIDIfa>; Tue, 4 Sep 2001 04:35:30 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:784 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S271906AbRIDIfZ>; Tue, 4 Sep 2001 04:35:25 -0400
Date: Tue, 4 Sep 2001 01:34:57 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: apm@csp.org.by, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: invalid depmod flag
Message-ID: <20010904013457.B6481@one-eyed-alien.net>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>, apm@csp.org.by,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010904105155.A8586@cyan> <15252.36364.884366.703245@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15252.36364.884366.703245@harpo.it.uu.se>; from mikpe@csd.uu.se on Tue, Sep 04, 2001 at 10:17:16AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Might is be possible to have the makefiles check the versions of some of
these tools?

Matt

On Tue, Sep 04, 2001 at 10:17:16AM +0200, Mikael Pettersson wrote:
> Artiom Morozov writes:
>  > during=20
>  > make modules_install
>  >=20
>  > depmod fails because flags -F is invalid and should be replaced with -m
>  > (imho!).
>  >=20
>  > Kernel 2.4.6
>  > depmod 2.1.121
>=20
> You're using obsolete modutils. Kernel 2.4.6 requires modutils 2.4.2 or n=
ewer
> (2.4.8 is the latest), as stated in the kernel's Documentation/Changes.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It's not that hard.  No matter what the problem is, tell the customer=20
to reinstall Windows.
					-- Nurse
User Friendly, 3/22/1998

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7lJIxz64nssGU+ykRAlFQAJ9BPGysRxrka0eT5zQ2WZGWXKzDpgCeMyYD
S+vFkncUevsvI9oaJ+U5M60=
=gKu2
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
