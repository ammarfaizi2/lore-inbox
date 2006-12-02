Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424272AbWLBRm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424272AbWLBRm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424276AbWLBRm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:42:59 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:51177 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1424272AbWLBRm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:42:58 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Bart Trojanowski <bart@jukie.net>
Subject: Re: nforce chipset + dualcore x86-64: Oops, NMI, Null pointer deref, etc
Date: Sat, 2 Dec 2006 18:40:43 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061202172208.GC20337@jukie.net>
In-Reply-To: <20061202172208.GC20337@jukie.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1782970.x7NQlc2OY9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612021840.48073.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1782970.x7NQlc2OY9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Samstag 02 Dezember 2006 18:22 schrieb Bart Trojanowski:
> In summary, I have an Opteron 170 in a Shuttle SN25P (nforce4 chipset).
> I've tested the ram overnight and swapped out every component in the
> system except for the HDDs.  I see these problems only with the
> dual-core, and even on an older Asus nforce4 based motherboard.
> noticed the following events (the complete dmesg is included below).

> [    0.000000] Nvidia board detected. Ignoring ACPI timer override.
> [    0.000000] If you got timer trouble try acpi_use_timer_override

Have you tried this?

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1782970.x7NQlc2OY9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcbqfxU2n/+9+t5gRAmvBAJ0RvxnezuMt5Is9GQHzriCojrvYZwCgjCmr
Idse/LBdr/KnxUtp3UggX8s=
=YPmu
-----END PGP SIGNATURE-----

--nextPart1782970.x7NQlc2OY9--
