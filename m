Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136710AbREATtj>; Tue, 1 May 2001 15:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136708AbREATt3>; Tue, 1 May 2001 15:49:29 -0400
Received: from adsl-63-199-250-45.dsl.sndg02.pacbell.net ([63.199.250.45]:8196
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S136706AbREATtM>; Tue, 1 May 2001 15:49:12 -0400
Date: Tue, 1 May 2001 12:48:25 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Geoffrey Gallaway <geoffeg@sin.sloth.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OnStream USB
Message-ID: <20010501124825.F23934@one-eyed-alien.net>
Mail-Followup-To: Geoffrey Gallaway <geoffeg@sin.sloth.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010501145859.A28980@sin.sloth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010501145859.A28980@sin.sloth.org>; from geoffeg@sin.sloth.org on Tue, May 01, 2001 at 02:58:59PM -0400
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm the owner of that first URL.

The driver works for me.  Make sure you enable the "Freecom USB/ATAPI"
support under the USB Mass Storage option in the kernel configuration.

Note that this is only supported for 2.4.x series kernels.

Matt

On Tue, May 01, 2001 at 02:58:59PM -0400, Geoffrey Gallaway wrote:
> Hello,
>=20
> I am considering getting an OnStream USB tape backup drive. I want the
> USB version because I have about 4 machines all on different networks
> that need to be backed up. Using USB would allow me to move the unit
> from one machine to another without rebooting the machine.
>=20
> I see that the SCSI version of the drive seems to be supported in linux
> but I can only find tidbits of information that don't confirm or deny
> this. Listed below are two sites that have some information which seem=20
> to confirm that the drive does indeed work, but I simply want to be=20
> sure.
>=20
> http://www2.one-eyed-alien.net/~mdharm/linux-usb/
> http://linux1.onstream.nl/test/
>=20
> Thank you,
> Geoff
>=20
> --=20
> Geoffrey Gallaway ||=20
> geoffeg@sloth.org || Clones are people two.
> D e v o r z h u n ||
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE67xMJz64nssGU+ykRAqWvAJwIXj+SoU8UQj1Nnw4Uh3peQN/h8gCgo/CK
MWhUZYHycYZtdX70n2UG1U4=
=fzF8
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
