Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135663AbRALXYm>; Fri, 12 Jan 2001 18:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135717AbRALXYd>; Fri, 12 Jan 2001 18:24:33 -0500
Received: from ziggy.one-eyed-alien.net ([216.120.107.189]:2566 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S135663AbRALXYV>; Fri, 12 Jan 2001 18:24:21 -0500
Date: Fri, 12 Jan 2001 15:24:15 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "Robert J. Bell" <rob@bellfamily.org>
Cc: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: USB Mass Storage in 2.4.0
Message-ID: <20010112152415.B5798@one-eyed-alien.net>
Mail-Followup-To: "Robert J. Bell" <rob@bellfamily.org>,
	kernel-list <linux-kernel@vger.kernel.org>
In-Reply-To: <3A5F8956.9040305@bellfamily.org> <20010112151008.A5798@one-eyed-alien.net> <3A5F9108.4030706@bellfamily.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3A5F9108.4030706@bellfamily.org>; from rob@bellfamily.org on Fri, Jan 12, 2001 at 03:19:36PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hrm... from these logs, everything looks okay, except for the fact that the
device refuses to return any INQUIRY data.

Can you reproduce the conditions under which it was working and send logs
from that?  Or at least remember what the /proc/scsi/scsi info looked like?

Matt

On Fri, Jan 12, 2001 at 03:19:36PM -0800, Robert J. Bell wrote:
> Matthew here is the info you requested, thanks for your help.
>=20
>=20



--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

What the hell are you?
					-- Pitr to Dust Puppy=20
User Friendly, 12/3/1997

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6X5Ifz64nssGU+ykRAmkmAKDIMbA6AQbnlL2+jTmf4796O4XarwCg41OS
NhSXRiEjAS9kohT39exDgU4=
=EMLH
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
