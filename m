Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265083AbSJaBP4>; Wed, 30 Oct 2002 20:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265084AbSJaBP4>; Wed, 30 Oct 2002 20:15:56 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:8577 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S265083AbSJaBPx>; Wed, 30 Oct 2002 20:15:53 -0500
Date: Thu, 31 Oct 2002 02:22:18 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.45
Message-Id: <20021031022218.2cb81b2e.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=./.dC9g5P_sXkx1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=./.dC9g5P_sXkx1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2002 16:56:29 -0800 (PST) Linus Torvalds (LT) wrote:

LT> Summary of changes from v2.5.44 to v2.5.45
LT> ============================================

[...]

fs/nfsd/nfs4proc.c: In function `nfsd4_write':
fs/nfsd/nfs4proc.c:484: warning: passing arg 4 of `nfsd_write' from incompatible pointer type
fs/nfsd/nfs4proc.c:484: warning: passing arg 6 of `nfsd_write' makes integer from pointer without a cast
fs/nfsd/nfs4proc.c:484: too few arguments to function `nfsd_write'
fs/nfsd/nfs4proc.c: In function `nfsd4_proc_compound':
fs/nfsd/nfs4proc.c:568: structure has no member named `rq_resbuf'
fs/nfsd/nfs4proc.c:569: structure has no member named `rq_resbuf'
fs/nfsd/nfs4proc.c:569: structure has no member named `rq_resbuf'
make[3]: *** [fs/nfsd/nfs4proc.o] Error 1

Regards,
-Udo.

--=./.dC9g5P_sXkx1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9wIXKnhRzXSM7nSkRAkIKAJ97nMxRIGxG28DRLY6r7kBxbN1J+wCfdIhI
aWLo6NJJMrvsyEzpcTwy9AI=
=ED+F
-----END PGP SIGNATURE-----

--=./.dC9g5P_sXkx1--
