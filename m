Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbULKOxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbULKOxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 09:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbULKOxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 09:53:09 -0500
Received: from mx.laposte.net ([80.245.62.11]:19637 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S261944AbULKOxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 09:53:01 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v7jL2iZfbA4IaYX966+g"
Organization: Adresse personelle
Date: Sat, 11 Dec 2004 15:52:52 +0100
Message-Id: <1102776772.2968.4.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v7jL2iZfbA4IaYX966+g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Just FYI real-time kernels do not boot on my Fedora Devel (Rawhide)
system, including -RT-2.6.10-rc2-mm3-V0.7.32-12. 2.6.10-rc2-mm4 OTOH
boots fine. It freezes just after initial hardware init before going
into gfx mode.

(kernel config available on demand, it's almost the same - 2.6.10-rc2-
mm4 was generated using a make oldconfig on the -RT-2.6.10-rc2-mm3-
V0.7.32-12 file)

Regards,

--=20
Nicolas Mailhot

--=-v7jL2iZfbA4IaYX966+g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBuwnDI2bVKDsp8g0RAnutAKDd1SC9f/kxnrDrMu5pGhPbpW4ayQCdEz9X
QLOrg+EDttcQhIee1sdkC3k=
=mxxj
-----END PGP SIGNATURE-----

--=-v7jL2iZfbA4IaYX966+g--
