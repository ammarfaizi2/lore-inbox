Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261273AbTCYADH>; Mon, 24 Mar 2003 19:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbTCYADH>; Mon, 24 Mar 2003 19:03:07 -0500
Received: from iucha.net ([209.98.146.184]:52068 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id <S261273AbTCYADG>;
	Mon, 24 Mar 2003 19:03:06 -0500
Date: Mon, 24 Mar 2003 18:14:14 -0600
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.66
Message-ID: <20030325001414.GX18830@iucha.net>
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H7BIH7T1fRJ3RGOi"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com>
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H7BIH7T1fRJ3RGOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

drivers/char/genrtc.c:100: warning: static declaration for
`gen_rtc_interrupt' follows non-static
drivers/char/genrtc.c: In function `gen_rtc_timer':
drivers/char/genrtc.c:135: warning: comparison of distinct pointer
types lacks a cast
drivers/char/genrtc.c: In function `gen_rtc_open':
drivers/char/genrtc.c:358: warning: `MOD_INC_USE_COUNT' is deprecated
(declared
at include/linux/module.h:431)
drivers/char/genrtc.c: In function `gen_rtc_release':
drivers/char/genrtc.c:377: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared
at include/linux/module.h:443)
drivers/char/genrtc.c: In function `gen_rtc_proc_output':
drivers/char/genrtc.c:453: void value not ignored as it ought to be
drivers/char/genrtc.c:498: `RTC_BATT_BAD' undeclared (first use in
this function)
drivers/char/genrtc.c:498: (Each undeclared identifier is reported
only once
drivers/char/genrtc.c:498: for each function it appears in.)

florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--H7BIH7T1fRJ3RGOi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+f59WNLPgdTuQ3+QRAiEIAKCOgLbuA7ocMWBwc/eVoYkQxWJgEwCdEy3q
pq1NAzU88qKz8SoBRm7pW24=
=xZ+X
-----END PGP SIGNATURE-----

--H7BIH7T1fRJ3RGOi--
