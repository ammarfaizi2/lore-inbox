Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWCLXTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWCLXTR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWCLXTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:19:17 -0500
Received: from pool-68-237-228-215.ny325.east.verizon.net ([68.237.228.215]:7679
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S1751920AbWCLXTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:19:15 -0500
Subject: Re: Linux v2.6.16-rc6
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: Jeff Garzik <jeff@garzik.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <4414A6BF.3030604@garzik.org>
References: <1142189154.21274.20.camel@blaze.homeip.net>
	 <4414A6BF.3030604@garzik.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9pxbLJH0t+4dbyFKjE5I"
Date: Sun, 12 Mar 2006 18:19:31 -0500
Message-Id: <1142205571.10354.1.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 Dropline GNOME 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9pxbLJH0t+4dbyFKjE5I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-03-12 at 17:54 -0500, Jeff Garzik wrote:
> Paul Blazejowski wrote:
> > sata_nv 0000:00:07.0: version 0.8
>=20
> sata_nv
>=20
> > ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xC400 irq 21
> > ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xC408 irq 21
>=20
> host max udma6
>=20
> > ata3: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
> > ata3: dev 0 configured for UDMA/100
>=20
> dev max udma5, configured for max speed
>=20
> > ata4: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
> > ata4: dev 0 configured for UDMA/133
>=20
> dev max udma6, configured for max speed
>=20
> Everything is correct.
>=20
> 	Jeff
>=20
>=20
>=20

Jeff, thank you for confirming that everything looks correct. Next time
i will be buying matching drives at the same time :-).

Cheers!

Paul B.

--=-9pxbLJH0t+4dbyFKjE5I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEFKyDwu5Nmh3PsiMRAhaQAJ9UAK99Z8MFc84h7ef5yVpeblLHlACaAnin
45jSd0ayjpeLoy+SzdqI8Ks=
=lz7f
-----END PGP SIGNATURE-----

--=-9pxbLJH0t+4dbyFKjE5I--

