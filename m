Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbSKSNfb>; Tue, 19 Nov 2002 08:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSKSNfb>; Tue, 19 Nov 2002 08:35:31 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37070 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265238AbSKSNfa>;
	Tue, 19 Nov 2002 08:35:30 -0500
Subject: Re: [LTP] Re: LTP - gettimeofday02 FAIL
From: Paul Larson <plars@linuxtestproject.org>
To: jim.houston@attbi.com
Cc: lkml <linux-kernel@vger.kernel.org>,
       high-res-timers-discourse@lists.sourceforge.net,
       ltp-list@lists.sourceforge.net, jim.houston@ccur.com
In-Reply-To: <200211190127.gAJ1RWg11023@linux.local>
References: <200211190127.gAJ1RWg11023@linux.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-S0W2GwSaXYsMK/f8RN7V"
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Nov 2002 07:37:23 -0600
Message-Id: <1037713044.24031.15.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S0W2GwSaXYsMK/f8RN7V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-11-18 at 19:27, Jim Houston wrote:
>=20
> Hi Everyone,
>=20
> I just tried gettimeofday02 on an old pentium-pro dual processor, and yes
> the time goes backwards with a 2.5.48 kernel.
This has been noticed, I've posted to lkml about it.  The only person
who replied to me seems to be suggesting it is a hardware issue, but I
can't believe it is impossible to work around.

-Paul Larson

--=-S0W2GwSaXYsMK/f8RN7V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj3aPpMACgkQbkpggQiFDqcMUQCbBZlKk+Ax5eCMKSSFteSELt2o
VdMAn2YxcPAXfakF3QuWgfd3byGj2OBF
=TQa/
-----END PGP SIGNATURE-----

--=-S0W2GwSaXYsMK/f8RN7V--

