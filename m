Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbULCXBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbULCXBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 18:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbULCXBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 18:01:42 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10881 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262451AbULCXBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 18:01:39 -0500
Subject: 2.4.28-lck1
From: Eric Hustvedt <lkml@plumlocosoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jE3VDUqhq8dEqW7lQM7Y"
Date: Fri, 03 Dec 2004 17:57:46 -0500
Message-Id: <1102114666.31017.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jE3VDUqhq8dEqW7lQM7Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have updated the lck patchset. This is the patchset formerly known as
the 2.4-ck patchset. I apologize for the long delay in releasing this
patch, but paid work had to come first.

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
POSIX ACL/xattr v0.8.71
POSIX extended security attributes v0.8.71
NTFS file system v2.1.6b

Updated:
- I have merged PPC fixes for the O(1) scheduler and the variable hertz
patch, so 32-bit PPC kernels should work now.
- I have attempted to make the patchset gcc 3.4 compatible. If I have
missed anything, let me know.

Pending:
- GRsec update to version 2.0.2.

-Eric

--=-jE3VDUqhq8dEqW7lQM7Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBsO9q8O0ZDXGTPEIRAk8vAJ0UUW+vI7ZaGDKVhrbtpIc0K+54/wCeP1rO
KJueDoOuVBL6LmWQ8FpzyYk=
=m4vO
-----END PGP SIGNATURE-----

--=-jE3VDUqhq8dEqW7lQM7Y--

