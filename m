Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTLAKLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 05:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTLAKLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 05:11:32 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:38529 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S262794AbTLAKLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 05:11:30 -0500
Date: Mon, 1 Dec 2003 02:11:18 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB mass-storage hell
Message-ID: <20031201101118.GA23531@one-eyed-alien.net>
Mail-Followup-To: Christian Axelsson <smiler@lanil.mine.nu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FCB001C.7000705@lanil.mine.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <3FCB001C.7000705@lanil.mine.nu>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Look at sysfs and the lsscsi application.

Matt

On Mon, Dec 01, 2003 at 09:47:24AM +0100, Christian Axelsson wrote:
> I have this USB harddrive and a USB mp3-player, when I plug them in=20
> would like them to be mounted at /mnt/hd and /mnt/mp3 by auto.
> Is this possible using 2.6 and some supermount-like daemon?
>=20
> Also, the device I plugin first becomes /dev/sda1 and the second=20
> /dev/sda2 (using devfs) so I cant rely upon device names here to do=20
> anything. Is there any ID of the USB-device aviable somewhere that can=20
> be of any use?
>=20
> --=20
> Christan Axelsson
> smiler@lanil.mine.nu
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I need a computer?
					-- Customer
User Friendly, 2/19/1998

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/yxPGIjReC7bSPZARAoA8AKDW+GAgBHalXv1p+H2tAybquPuk2wCfeQCs
tyzEjZH2x5prEZX0U37jCGw=
=BL8b
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
