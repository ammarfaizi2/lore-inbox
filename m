Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVAMBKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVAMBKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVAMBG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:06:59 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:52871 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S261502AbVALVwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 16:52:23 -0500
From: Mws <mws@twisted-brains.org>
To: linux-kernel@vger.kernel.org
Subject: Re: pci express error on ASUS P5AD2
Date: Wed, 12 Jan 2005 22:52:29 +0100
User-Agent: KMail/1.7.2
References: <200501101424.41686.mws@twisted-brains.org>
In-Reply-To: <200501101424.41686.mws@twisted-brains.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1280830.guksHG2Gk4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501122252.39603.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1280830.guksHG2Gk4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 10 January 2005 14:24, you wrote:
> Hi,
>=20
> i am using an ASUS P5AD2Premium Board with a P4 3,4 LGA 775 CPU.
>=20
> This one has got 2 Gigabit PCI Express Ethernet cards on-board.
>=20
> lspci=20
>=20
> 0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit E=
thernet Controller (rev 15)
> 0000:03:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit E=
thernet Controller (rev 15)
>=20
> both 2 are working, but when i load the driver modules=20
> i get 2 unrecoverable PciExpress Hardware failures.
>=20
> Drivers are not implemented in the Kernel Mainstream but as syskonnect to=
ld me, already send to the devs.
>=20
> Driver version from syskonnect is v 7.09
>=20
> obtainable @
>=20
> http://www.syskonnect.com/syskonnect/support/driver/htm/sk9e21_lin.htm
>=20
>=20
> help is appreciated. just mail me for more information if needed.
>=20
> regards
> marcel
>=20
Hi,

it does still appear with 2.6.11-rc1

eth0: -- ERROR --
        Class:  Hardware failure
        Nr:  0x271
        Msg:  Uncorrectable PCI Express error
eth1: -- ERROR --
        Class:  Hardware failure
        Nr:  0x271
        Msg:  Uncorrectable PCI Express error


regards
marcel

--nextPart1280830.guksHG2Gk4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB5ZwnPpA+SyJsko8RAplhAKCmJkpQRcCXyaQG8PfJzxurezi1XwCgmVFQ
VGCiZC4X1iwoOcT2JThHIXg=
=LToV
-----END PGP SIGNATURE-----

--nextPart1280830.guksHG2Gk4--
