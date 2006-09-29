Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWI2KBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWI2KBP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 06:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWI2KBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 06:01:15 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:54700 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750761AbWI2KBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 06:01:14 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA status reports update
Date: Fri, 29 Sep 2006 12:00:56 +0200
User-Agent: KMail/1.9.4
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <451CE8EC.1020203@garzik.org> <200609291149.37009.prakash@punnoor.de> <451CED23.1090909@garzik.org>
In-Reply-To: <451CED23.1090909@garzik.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1540062.iuFlL0M7mx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609291200.56308.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1540062.iuFlL0M7mx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag 29 September 2006 11:53 schrieb Jeff Garzik:
> Prakash Punnoor wrote:
> > Am Freitag 29 September 2006 11:35 schrieb Jeff Garzik:
> >> I updated the info at http://linux-ata.org/ to match the current code =
in
> >> linux-2.6.git.
> >>
> >> Hardware and driver status:
> >> 	http://linux-ata.org/driver-status.html
> >>    notably, the driver matrix:
> >> 	http://linux-ata.org/driver-status.html#matrix
> >
> > Does any ETA exists for NV NON-AHCI NCQ support? The proabably not so
> > small userbase would be happy if work on it would be done...
>
> No ETA at all.  It is admittedly low priority, and unfortunately the
> only people with hardware documentation are myself and NVIDIA.
>
> There is a non-working patch, if someone wants to debug it, though:
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/archive/2.6.=
17
>-nv-adma.patch.bz2

Well, how would one debug it w/o hw docs? Or is it possible to compare the=
=20
patch with a working driver for another chipset?
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1540062.iuFlL0M7mx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFHO7YxU2n/+9+t5gRArq6AKC+/0EYDaCCUWnVDpX0+WHpZqu7qACgnySr
9g1INrWDI9NZV2elt/MSAvs=
=bbad
-----END PGP SIGNATURE-----

--nextPart1540062.iuFlL0M7mx--
