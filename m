Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSGOTpj>; Mon, 15 Jul 2002 15:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317624AbSGOTpi>; Mon, 15 Jul 2002 15:45:38 -0400
Received: from [209.184.141.189] ([209.184.141.189]:44571 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317623AbSGOTpi>;
	Mon, 15 Jul 2002 15:45:38 -0400
Subject: Some sysctl parameter change questions.
From: Austin Gonyou <austin@coremetrics.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-84isx0wKXrZxSKLugtOS"
Organization: Coremetrics, Inc.
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 15 Jul 2002 14:48:25 -0500
Message-Id: <1026762505.14251.6.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-84isx0wKXrZxSKLugtOS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Looking through some tuning documentation about sysctl values as related
to Oracle and other DB tuning bits, I noticed that the following don't
exist anymore, and was curious where or if they were moved.

/proc/sys/kernel/inode-max
/proc/sys/vm/freepages

In coincidence with this info, I was curious if anyone has tweaked the
following and if it makes any difference, with regard to performance:

/proc/fs/pagebuf
/proc/sys/vm/pagebuf
/proc/sys/vm/pagebuf/max_dio_pages
/proc/sys/vm/page-cluster
/proc/sys/vm/pagetable_cache


--=20
Austin Gonyou <austin@coremetrics.com>
Coremetrics, Inc.

--=-84isx0wKXrZxSKLugtOS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9MycJ94g6ZVmFMoIRAhiWAKCPW7tSYWl3P/wSVUueoWM9XZ1Q7ACfffZs
gu4vdlpBONNE0b0MGqYulp4=
=kdkf
-----END PGP SIGNATURE-----

--=-84isx0wKXrZxSKLugtOS--
