Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267923AbTBRTKH>; Tue, 18 Feb 2003 14:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267929AbTBRTKH>; Tue, 18 Feb 2003 14:10:07 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:21467 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267923AbTBRTKG>;
	Tue, 18 Feb 2003 14:10:06 -0500
Subject: [ANNOUNCE] 2.5 kernel errata list
From: Paul Larson <plars@linuxtestproject.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-7Ooz6yp7c3SPO3hZz7w7"
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 Feb 2003 13:13:59 -0600
Message-Id: <1045595639.28493.197.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7Ooz6yp7c3SPO3hZz7w7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Based on a suggestion and several people saying they would find it
useful, I'm keeping a kernel errata page on the Linux Test Project
website at http://ltp.sourceforge.net/errata

I'll try to maintain a list of known fixes for blocking problems with
the most recent kernel on this page.  By "blocking", I mean anything
severe enough to keep you from testing the kernel (can't compile, panic
on boot, catches your hair on fire, etc).  This is _not_ a replacement
for the bug tracking system.  I won't put anything here that doesn't
have a fix or a workaround.  So if you're looking for an exhaustive list
of problems for a given kernel, look at bugme, but if all you want is a=20
list of known fixes to get you up and running quickly, the errata list
should give you a quick and easy answer.

If you have any suggestions to make this more useful or if you see
anything I've missed, please let me know.

Thanks,
Paul Larson

--=-7Ooz6yp7c3SPO3hZz7w7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj5ShfcACgkQbkpggQiFDqd48gCgj7cOgxH2NAcDoIuC8401sMt6
7OAAmwX7MZtZbjrmWlIOIZ+BiS9UssO7
=hUmR
-----END PGP SIGNATURE-----

--=-7Ooz6yp7c3SPO3hZz7w7--

