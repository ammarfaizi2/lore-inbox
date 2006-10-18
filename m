Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbWJRPku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbWJRPku (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWJRPku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:40:50 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:31905 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1161169AbWJRPkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:40:49 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Sebastian Biallas <sb@biallas.net>
Subject: Re: PCI-DMA: Disabling IOMMU
Date: Wed, 18 Oct 2006 17:41:03 +0200
User-Agent: KMail/1.9.5
References: <45364248.2020901@biallas.net>
In-Reply-To: <45364248.2020901@biallas.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1886508.S28QdfIql7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610181741.03428.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1886508.S28QdfIql7
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch 18 Oktober 2006 17:03 schrieben Sie:
> Hi,
>
> Linux ouputs some strange "PCI-DMA: Disabling IOMMU" on booting. It's a
> ALiveNF4G motherboard with an Athlon64 X2 running vanilla Linux 2.6.18.1
> (which supports all hardware out of the box, pretty cool).
>
> Should I worry about this IOMMU-disabling? All other Linux/IOMMU stuff I
> found had AGP or BIOS messages nearby, but I only get this single
> "PCI-DMA: Disabling IOMMU" line, without any hint.

Unless you have >=3D4GB of RAM using IOMMU makes no sense, thus it gets=20
disabled.

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1886508.S28QdfIql7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFNksPxU2n/+9+t5gRAgznAKCkz3KCZ5z/7PQp3U3PcTqM8hQ1cwCg1j8T
Uke/5HJpwt6bH5SvnDd+Gg4=
=h+ta
-----END PGP SIGNATURE-----

--nextPart1886508.S28QdfIql7--
