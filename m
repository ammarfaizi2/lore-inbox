Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbTGVIHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 04:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270139AbTGVIHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 04:07:11 -0400
Received: from adsl-67-124-157-42.dsl.pltn13.pacbell.net ([67.124.157.42]:5856
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S267520AbTGVIHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 04:07:09 -0400
Date: Tue, 22 Jul 2003 01:22:12 -0700
To: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - ac2-test1: Removing the obselete EXPORT_NO_SYMBOLS
Message-ID: <20030722082212.GA24515@triplehelix.org>
References: <200307221342.30374.krishnakumar@naturesoft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <200307221342.30374.krishnakumar@naturesoft.net>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2003 at 01:42:30PM +0530, Krishnakumar. R wrote:
>  #ifndef METH_DEBUG
> -	EXPORT_NO_SYMBOLS;
>  #endif

Why not just pull the whole #ifdef/#endif?

-Josh

--=20
Using words to describe magic is like using a screwdriver to cut roast beef.
		-- Tom Robbins

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/HPQ0T2bz5yevw+4RAjrFAJ4h8mlS2g4OQIr8cdl77mX8kh0z6wCfbUYR
0PthozbGpo02jyyh2lBagY4=
=4RMo
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
