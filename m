Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbTAPEUD>; Wed, 15 Jan 2003 23:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbTAPEUD>; Wed, 15 Jan 2003 23:20:03 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:5088
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S266952AbTAPEUC>; Wed, 15 Jan 2003 23:20:02 -0500
Date: Wed, 15 Jan 2003 20:28:53 -0800
To: linux-kernel@vger.kernel.org
Subject: [2.5] X losing keyboard
Message-ID: <20030116042853.GA1636@fuuma>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: "Joshua M. Kwan" <joshk@mspencer.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

X loses the keyboard after switching to a TTY in 2.5.58-dj1-bk and then=20
back to X. This is 100% reproducible. Is this a known bug?

Also, I get a lot of MTRR 1 and MTRR 2 not used notices after I quit X.=20
But the performance seems the same either way (X performance compared=20
between 2.4 and 2.5 kernels,) so is this a false positive?

Hope to hear from you all soon...

Regards
Josh

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+JjUF6TRUxq22Mx4RArRTAJ0fxPnDwEh01k8KY8t+Au0eO6EfJwCeNCyz
bL8Un5LN4EY96rK59Jf8k08=
=QXMy
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
