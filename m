Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270643AbTHJStE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 14:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270645AbTHJStE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 14:49:04 -0400
Received: from 4demon.com ([217.160.186.4]:52905 "EHLO pro-linux.de")
	by vger.kernel.org with ESMTP id S270643AbTHJStB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 14:49:01 -0400
Date: Sun, 10 Aug 2003 20:48:58 +0200
From: Hans-Joachim Baader <hjb@pro-linux.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3: "core" module
Message-ID: <20030810184857.GA23829@kiwi.hjbaader.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

The serial driver module 8250 depends on a module named "core". Isn't
that a silly name? I suggest renaming it to serialcore or sercore.

Regards,
hjb
--=20
Pro-Linux - Germany's largest volunteer Linux support site
http://www.pro-linux.de/          Public Key ID 0x3DDBDDEA

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/NpOZLbySPj3b3eoRAlD5AJ9AehaVBbq7qCKh1w9rbbVlwXpp7QCgih2H
RLXYK/ra/lyhi1K0z6zTEE8=
=Vp91
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
