Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbTANGLY>; Tue, 14 Jan 2003 01:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267470AbTANGLY>; Tue, 14 Jan 2003 01:11:24 -0500
Received: from h80ad26f3.async.vt.edu ([128.173.38.243]:52610 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267471AbTANGLX>; Tue, 14 Jan 2003 01:11:23 -0500
Message-Id: <200301140619.h0E6JSqZ024785@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: linus@transmeta.com, Massimo Dal Zotto <dz@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Linux 2.5.57, i8k driver versions..
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-545380929P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Jan 2003 01:19:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-545380929P
Content-Type: text/plain; charset=us-ascii

The Linux 2.5.57 tarball has the 1.7 version of the i8k driver, but
the version in http://people.debian.org/~dz/i8k/i8kutils-1.17.tar.bz2
is version 1.13.  A quick diff doesn't show anything that would prevent
a drop-in of the 1.13 version.  What's the protocol to get this
synced to the latest-and-greatest?
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-545380929P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+I6vvcC3lWbTT17ARAiLwAJ4uBrGRvtH+ZbVFc9am3Rt3NYzxZQCg+7sQ
z/Emuz5rcqYklJCl5AAjC9c=
=L97a
-----END PGP SIGNATURE-----

--==_Exmh_-545380929P--
