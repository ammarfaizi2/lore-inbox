Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319857AbSINIj5>; Sat, 14 Sep 2002 04:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319861AbSINIj5>; Sat, 14 Sep 2002 04:39:57 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:6056 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319857AbSINIj4>; Sat, 14 Sep 2002 04:39:56 -0400
Date: Sat, 14 Sep 2002 10:44:40 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre7 config errors
Message-ID: <20020914084436.GC6178@mandel.hjbaader.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In certain configurations (small or minimal), with "make menuconfig",
it is not possible to enter the submenus for

 Fusion MPT device support
 ISDN support
 I2O device support

I don't know on which configuration these depend, but it would be nice if
they told the user the reason rather than doing nothing.

Regards,
hjb
--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment:  

iD8DBQE9gvbzLbySPj3b3eoRAmBgAJwP7QYknARZ1r+KyAYrEAFkMMHWPwCfXwPP
TPsw6wFEdORM4m9GBKuYXzg=
=Vzhn
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
