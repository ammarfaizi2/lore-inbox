Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbTLVWIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTLVWIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:08:41 -0500
Received: from svr8.m-online.net ([62.245.150.237]:31429 "EHLO
	mail-in.m-online.net") by vger.kernel.org with ESMTP
	id S264501AbTLVWIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:08:36 -0500
Subject: Speedup reading from broken hdd
From: Florian Huber <florian.huber@mnet-online.de>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Hb1923acUrEvKm1NgtsC"
Message-Id: <1072130914.3618.12.camel@laptop.lindoze.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Dec 2003 23:08:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hb1923acUrEvKm1NgtsC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello ML,
I have one broken harddisk, but most of the sectors are still ok.
Whenn I try to dump the data via dd_rescue and it comes to faulty
bytes/bits/whatever the kernel takes a lot of time (retries, timeout?)
till it recognizes that it's broken. (The usual error in kernel log...).

Is there a possibilty to speed this up? Maybe there is a kernel patch or
I can access this device in a different way?

TIA

--=20
Florian Huber

Key ID: D9D50EA2
Fingerprint: 0241 C329 E355 9B94 8D34 F637 4EB9 1B1D D9D5 0EA2

BOFH Excuse #274:
It was OK before you touched it.

--=-Hb1923acUrEvKm1NgtsC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/52tiTrkbHdnVDqIRAoT7AJ45v1Hren8dvpcQIbMeCddYhgO7nQCfb5ZI
qWBsIJ/yHaithXNmoazDDcY=
=sag9
-----END PGP SIGNATURE-----

--=-Hb1923acUrEvKm1NgtsC--

