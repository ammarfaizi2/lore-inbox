Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSLYSzT>; Wed, 25 Dec 2002 13:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261206AbSLYSzT>; Wed, 25 Dec 2002 13:55:19 -0500
Received: from mx2.mail.ru ([194.67.57.12]:18955 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id <S261205AbSLYSzS>;
	Wed, 25 Dec 2002 13:55:18 -0500
Date: Wed, 25 Dec 2002 22:06:51 +0300
From: Nick Kurshev <nickols_k@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [BUG???] EXT3FS+VM86+/dev/mem+pthread=segfault
Message-Id: <20021225220651.2e356089.nickols_k@mail.ru>
Organization: HomePC
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.MO4N7xtaR9_Y+M"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.MO4N7xtaR9_Y+M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello!

Sorry! Forget to add - this bug happens with any kernels include 2.4.20 (I don't use DEV_FS)
I've tested this behaviour with glibc-2.1.3 and glibc-2.2.5.

WBR! Nick





--=.MO4N7xtaR9_Y+M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+CgHMB/1cNcrTvJkRAhNhAKCm7pCbOoSkXvlD+kUugs05SfA7WgCfe3fS
qBJq1V09DuRnkWPBRM+7vHw=
=XA5d
-----END PGP SIGNATURE-----

--=.MO4N7xtaR9_Y+M--

