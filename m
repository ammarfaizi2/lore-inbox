Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264693AbUDVV4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbUDVV4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbUDVV4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:56:35 -0400
Received: from resin.csoft.net ([63.111.22.86]:61882 "HELO mail231.csoft.net")
	by vger.kernel.org with SMTP id S264693AbUDVV4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:56:33 -0400
Subject: 2.4.26-lck1
From: Eric Hustvedt <lkml@plumlocosoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+klIh85CQ+zOZwqoGTCt"
Message-Id: <1082670990.3327.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Apr 2004 17:56:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+klIh85CQ+zOZwqoGTCt
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
POSIX ACL/xattr v0.8.71
POSIX extended security attributes v0.8.71
NTFS file system v2.1.6a

Added:
- The extended security attribute patch from the POSIX ACL patchset has
been incorporated.

Updated:
- POSIX ACLs updated to latest version.
- A few minor fixes for preemption on PPC hardware have been rolled in.

Pending:
- GRsec update.

-Eric

--=-+klIh85CQ+zOZwqoGTCt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAiD+E8O0ZDXGTPEIRAgsQAJwPbhEgYxKuVubKfVGYezt02ueC1gCfSHcT
qAJi+eTCXZk43LEVEVokPWI=
=pKxb
-----END PGP SIGNATURE-----

--=-+klIh85CQ+zOZwqoGTCt--

