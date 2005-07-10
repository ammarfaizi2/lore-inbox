Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261861AbVGJHFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbVGJHFm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 03:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVGJHFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 03:05:42 -0400
Received: from resin.csoft.net ([63.111.22.86]:20596 "HELO mail231.csoft.net")
	by vger.kernel.org with SMTP id S261861AbVGJHFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 03:05:40 -0400
Subject: 2.4.31-lck1
From: Eric Hustvedt <lkml@plumlocosoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-L99m0zkrk6UNSpnt0U6O"
Date: Sun, 10 Jul 2005 03:05:18 -0400
Message-Id: <1120979118.961.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-L99m0zkrk6UNSpnt0U6O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Updated the lck patchset. This is the patchset formerly known as the
2.4-ck patchset.

http://www.plumlocosoft.com/kernel/

Includes:
O(1) scheduler with batch scheduling, interactivity
Preemptible kernel
Low Latency
Read Latency2
Variable Hz
64-bit jiffies
Supermount-NG v1.2.11a
Bootsplash v3.0.7
POSIX ACL/xattr v0.8.73
POSIX extended security attributes v0.8.73
NTFS file system v2.1.6b

Updated:
- POSIX ACLs updated to the latest release.

Pending:
- GRsec update to version 2.1.6.

--=20
Eric Hustvedt <lkml@plumlocosoft.com>

--=-L99m0zkrk6UNSpnt0U6O
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC0Miu8O0ZDXGTPEIRAuJOAJ9JsNAt2xCjqkeb+SUR+WQaIDE2+QCggSQu
M0lSAsjtZHRJt5dxv5CaiKc=
=O5Si
-----END PGP SIGNATURE-----

--=-L99m0zkrk6UNSpnt0U6O--

