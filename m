Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbSKYTNY>; Mon, 25 Nov 2002 14:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbSKYTNY>; Mon, 25 Nov 2002 14:13:24 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:41806 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S265378AbSKYTNX>;
	Mon, 25 Nov 2002 14:13:23 -0500
Date: Mon, 25 Nov 2002 20:20:33 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.2.23-rc2 & an MCE
Message-ID: <20021125202033.A1212@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I just had an MCE on my aging PPro 200. Before I go out to
buy a replacement I would like to hear if it could be
caused by anything other than the CPU. Googling a bit
gave some indications that sometimes other HW might report
failure through this method.

The MCE (hand copied):

Machine Check Exception: 000000000000004
Bank 4: b200000000040151
Kernel panic: CPU context corrupt

Regards,
  Rasmus

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE94ngBlZJASZ6eJs4RAkt4AJ9al9mfIuHzOlK7enM8Vv6ZNI4zNgCfchJj
pxDhPf4AiTdzX67rKljYAXE=
=ERkU
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
