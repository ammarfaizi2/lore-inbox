Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbSLJPME>; Tue, 10 Dec 2002 10:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262130AbSLJPME>; Tue, 10 Dec 2002 10:12:04 -0500
Received: from B5b36.pppool.de ([213.7.91.54]:6547 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S262089AbSLJPMD>; Tue, 10 Dec 2002 10:12:03 -0500
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
From: Daniel Egger <degger@fhm.edu>
To: Dave Jones <davej@suse.de>
Cc: Joseph <jospehchan@yahoo.com.tw>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210072440.GB9124@suse.de>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw>
	 <20021210055215.GA9124@suse.de> <1039504941.30881.10.camel@sonja>
	 <20021210072440.GB9124@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YMIK32boH2HYdKRHR996"
Organization: 
Message-Id: <1039506805.31061.23.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Dec 2002 08:53:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YMIK32boH2HYdKRHR996
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Die, 2002-12-10 um 08.24 schrieb Dave Jones:

> Mine disagrees.

My bad, sorry. This conclusion came from a quick disassemble of a small
program I run on those boxes which indeed contain cmovs and I believed
that the boxes execercise the complete program but obviously not.=20

A quick check with a just written testprogram calculating some primes=20
revealed that -march=3Di686 -mcpu=3Di686 does *not* work...

--=20
Servus,
       Daniel

--=-YMIK32boH2HYdKRHR996
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA99Z10chlzsq9KoIYRAhzcAKDlY8bt8xKdyjnVte1UPGTL2H1waACfQJbG
oex8ZttaZ20mhqfn4Sv2JhA=
=r2az
-----END PGP SIGNATURE-----

--=-YMIK32boH2HYdKRHR996--

