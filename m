Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbUJZRfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbUJZRfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUJZRfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:35:09 -0400
Received: from pop.gmx.de ([213.165.64.20]:2442 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261346AbUJZRfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:35:02 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Neighbour table overflow.
Date: Tue, 26 Oct 2004 19:39:31 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5067748.EOvdfUQrjE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410261939.33541.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5067748.EOvdfUQrjE
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

can anybody explain why i get thousands of "Neighbour table overflow."=20
messages? i didn't get such ones with older kernels (~2.6.6).
here is a dmesg output:

printk: 54050 messages suppressed.
Neighbour table overflow.
printk: 10403 messages suppressed.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
Neighbour table overflow.
printk: 58524 messages suppressed.

this couldn't be ok, or?

best regards,
dominik

--nextPart5067748.EOvdfUQrjE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUAQX6L1QvcoSHvsHMnAQK1MwQAjwCZfw/cHLNoffKUIsShbkvNLlw/Kf94
Gjurmsmuh8KAgl5i/+0iZZ0p6AZUvs5cYVUvxQxuO9zv+tYXs6u2XVRqbt/lHyKv
YaHA2lxXg69b70mGsBOt8uW5woc/YeOPVkV8vFm5ABa2t1Zd4/LYJY0QSA6K7RPw
/rcoI57JoG4=
=B1/V
-----END PGP SIGNATURE-----

--nextPart5067748.EOvdfUQrjE--
