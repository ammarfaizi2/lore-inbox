Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317683AbSFSADj>; Tue, 18 Jun 2002 20:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317685AbSFSADi>; Tue, 18 Jun 2002 20:03:38 -0400
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:2179 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id <S317683AbSFSADh>; Tue, 18 Jun 2002 20:03:37 -0400
Subject: RE: Cache-attribute conflict bug in the kernel exposed on newer A
	MD Athlon CPUs
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: richard.brunner@amd.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206181908040.5120-100000@freak.distro.conectiva>
References: <Pine.LNX.4.44.0206181908040.5120-100000@freak.distro.conectiva>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-fqqkoc2Cb8z9ZerrRZ3a"
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 Jun 2002 17:03:38 -0700
Message-Id: <1024445018.3203.8.camel@camp4.serpentine.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fqqkoc2Cb8z9ZerrRZ3a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-06-18 at 15:08, Marcelo Tosatti wrote:

> I'll wait for your confirmation so this patch can go in -rc1.

Users of NVIDIA AGP graphics cards using NVIDIA's closed-source drivers
on recent Athlon CPUs should note that this patch will probably not fix
any stability problems they may be seeing.

A temporary workaround for those users is to turn off AGP altogether.=20
If you are using such a setup and see stability issues, please let me
know.

	<b

--=-fqqkoc2Cb8z9ZerrRZ3a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9D8paG8PvG6BKogcRAvHpAKDAVnfkysAcrfj7B9E6dA1YTdiYYgCgvDSG
cYRn1RUTQSTENyPCt1/9TKQ=
=sRXn
-----END PGP SIGNATURE-----

--=-fqqkoc2Cb8z9ZerrRZ3a--
