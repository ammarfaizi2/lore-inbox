Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbSLJVdt>; Tue, 10 Dec 2002 16:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbSLJVdt>; Tue, 10 Dec 2002 16:33:49 -0500
Received: from splat.lanl.gov ([128.165.17.254]:45521 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S267049AbSLJVdr>; Tue, 10 Dec 2002 16:33:47 -0500
Date: Tue, 10 Dec 2002 14:41:20 -0700
From: Eric Weigle <ehw@lanl.gov>
To: Stephan van Hienen <ultra@a2000.nu>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Alteon AceNIC Coper Seen as Fibre ? (and incorrect settings)
Message-ID: <20021210214120.GZ10934@lanl.gov>
References: <Pine.LNX.4.50.0212102157440.1634-100000@ddx.a2000.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uLcrxnkzOGy8pA6s"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0212102157440.1634-100000@ddx.a2000.nu>
User-Agent: Mutt/1.3.28i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uLcrxnkzOGy8pA6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> eth2: Alteon AceNIC Gigabit Ethernet at 0x1ff02900000, irq 6,7d0
=2E..
> eth2: 10/100BaseT link UP
> eth2: Optical link DOWN
> eth2: 10/100BaseT link UP
>=20
> but this card is not an Fibre (Optical) card ?
This is a hold-over from the first revision of the cards, which were all
optical; the driver was written at that point.

(Remember, the hideous copper GigE hack came out after the fiber did).

Unless there's some actual failure, just ignore it.


-Eric

--=20
------------------------------------------------------------
        Eric H. Weigle -- http://public.lanl.gov/ehw/
"They that can give up essential liberty to obtain a little
temporary safety deserve neither" -- Benjamin Franklin
------------------------------------------------------------

--uLcrxnkzOGy8pA6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE99l+A1LDXWFnqnE8RAkrdAKDigE9QmgtQlLH2QJGVblhQJGLmmgCfUbtf
78XrMC5sSJiIYaYwzC+wsgc=
=Fq1g
-----END PGP SIGNATURE-----

--uLcrxnkzOGy8pA6s--
