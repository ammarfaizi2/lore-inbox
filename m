Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTE0Mw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTE0Mw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:52:29 -0400
Received: from iucha.net ([209.98.146.184]:31810 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S263578AbTE0Mw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:52:26 -0400
Date: Tue, 27 May 2003 08:05:39 -0500
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ALSA problems: sound lockup, modules, 2.5.70
Message-ID: <20030527130539.GG3359@iucha.net>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <200305270311.10530.ivg2@cornell.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline
In-Reply-To: <200305270311.10530.ivg2@cornell.edu>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alsa worked fine for me in 2.5.68-bk18. It started hanging on halt
in -bk19 and .70. I haven't played anything to see if it hangs on
access.

florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+02KjNLPgdTuQ3+QRAjdcAJ98EXsjOQmeTTeA+ZAizALWkl6IGQCeOlef
EaRBA4i5eX37ZmBMjHJcWKQ=
=5G1X
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
