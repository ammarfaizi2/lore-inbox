Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131075AbQLaWN6>; Sun, 31 Dec 2000 17:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131088AbQLaWNj>; Sun, 31 Dec 2000 17:13:39 -0500
Received: from ziggy.one-eyed-alien.net ([216.120.107.189]:21002 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S131075AbQLaWNZ>; Sun, 31 Dec 2000 17:13:25 -0500
Date: Sun, 31 Dec 2000 13:41:42 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alastair Foster <alasta@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Camera as a USB mass storage / SCSI device
Message-ID: <20001231134142.D6652@one-eyed-alien.net>
Mail-Followup-To: Alastair Foster <alasta@mail.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <379744379.978294325610.JavaMail.root@web582-mc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <379744379.978294325610.JavaMail.root@web582-mc>; from alasta@mail.com on Sun, Dec 31, 2000 at 03:25:25PM -0500
Organization: One Eyed Alien Networks
X-Copyright: (C) 2000 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2000 at 03:25:25PM -0500, Alastair Foster wrote:
> Unfortunately, my camera does not get recognised on bootup. This is hardly
> surprising, given that the kernel has no way of determining the camera as=
 a
> USB mass storage device.  However, I'm curious as to how others have mana=
ged
> to get away with this by doing nothing more than compiling their kernel w=
ith
> the above options.

Not quite true... USB devices carry a ClassID, which (for most mass storage
devices) indicates that it is compliant to the USB Mass Storage
Specification.  So, the database is only for devices that are slightly out
of spec or have descriptors that are not truthful.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6T6gWz64nssGU+ykRAuUEAKDCeGrT8MP/JbR6lomo1af/QK37OACdEI7+
viCJX4p/wwCrzBN7KZj0Q2o=
=z3vm
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
