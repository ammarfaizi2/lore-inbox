Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262904AbVBCBOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbVBCBOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbVBCBM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:12:58 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:39849 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S262850AbVBCBMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:12:33 -0500
Date: Wed, 2 Feb 2005 17:12:24 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20050203011224.GA29748@one-eyed-alien.net>
Mail-Followup-To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
	stern@rowland.harvard.edu, linux-kernel@vger.kernel.org
References: <5F106036E3D97448B673ED7AA8B2B6B301B3CD73@scl-exch2k.phoenix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B301B3CD73@scl-exch2k.phoenix.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's basically just like the code says.

A lot of devices choke if you access them too quickly after enumeration.
The 5 second delay seems to be enough for most devices.  But we made it
adjustable exactly for people like you.

Matt

On Wed, Feb 02, 2005 at 04:17:13PM -0800, Aleksey Gorelov wrote:
> Hi Matt, Alan,=20
>=20
>   Could you please tell me (link would do) why it makes default
> delay_use=3D5=20
> really necessary (from the patch below)?
> https://lists.one-eyed-alien.net/pipermail/usb-storage/2004-August/00074
> 7.html
>=20
> It makes USB boot really painfull and slow :(
>=20
>   I understand there should be a good reason for it. I've tried to find
> an answer in=20
> archives, without much success though.
>=20
> Thanks,
> Aleks.

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Now payink attention, please.  This is mouse.  Click-click. Easy to=20
use, da? Now you try...
					-- Pitr to Miranda
User Friendly, 10/11/1998

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCAXp4IjReC7bSPZARAqplAJ9WD9TRlryVc1ikb8L4QZFsq+ezyQCgrnAw
qakC8xzTroMWe/o9zuY30Q4=
=kQBj
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
