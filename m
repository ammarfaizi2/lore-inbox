Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312178AbSCRC2x>; Sun, 17 Mar 2002 21:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312177AbSCRC2m>; Sun, 17 Mar 2002 21:28:42 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:36877 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S312175AbSCRC2c>; Sun, 17 Mar 2002 21:28:32 -0500
Date: Sun, 17 Mar 2002 18:28:26 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: =?iso-8859-1?Q?J=F6rg_Prante?= <joergprante@gmx.de>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linuxppc-user@lists.linuxppc.org
Subject: Re: [PATCH] LaCie USB CDRW
Message-ID: <20020317182826.B341@one-eyed-alien.net>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rg_Prante?= <joergprante@gmx.de>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linuxppc-user@lists.linuxppc.org
In-Reply-To: <200203171028.ALV49936@m1000.netcologne.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203171028.ALV49936@m1000.netcologne.de>; from joergprante@gmx.de on Sun, Mar 17, 2002 at 11:28:14AM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please send me the contents of /proc/bus/usb/devices when the device is
attached to the system.

Matthew Dharm

On Sun, Mar 17, 2002 at 11:28:14AM +0100, J=F6rg Prante wrote:
> Hi,
>=20
> here is a Linux Kernel USB definition of the LaCie USB CDRW burner. This=
=20
> was missing from linux/drivers/usb/storage/unusual_devs.h, so the drive w=
as=20
> recognized by USB, but not properly installed by the USB SCSI emulation.
>=20
> I tested only reading yet, but I think writing works, too. Will be tested=
=20
> soon. I have an old model of 1999 with USB 1, 2x/2x/4x, and no FireWire=
=20
> Combo. The USB one is mainly used by Apple folks for CD burning, and will=
=20
> make those people happy. Current model can be found at
>=20
> http://www.lacie.com/products/product.cfm?id=3D4A866A34-54C8-11D5-97C6009=
0278D3ED0
>=20
> This should be a fix to the LaCie USB burner trouble that has been report=
ed=20
> in September 2002 to linuxppc-user.
>=20
> http://www.geocrawler.com/mail/thread.php3?subject=3DLacie+USB+Burner&lis=
t=3D2
>=20
> Cheers,
>=20
> J=F6rg
> =20


--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Stef, you just got beaten by a ball of DIRT.
					-- Greg
User Friendly, 12/7/1997

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8lVDKz64nssGU+ykRAsfaAJ0YpR3KpjWHfOSU185mCjU5S3J1FACffWNa
M1eiHV/oKHCBEbY1J33VAAk=
=k+Qf
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
