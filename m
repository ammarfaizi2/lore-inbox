Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267587AbUHJQ5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbUHJQ5f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267612AbUHJQzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:55:32 -0400
Received: from resin.csoft.net ([63.111.22.86]:6725 "HELO mail231.csoft.net")
	by vger.kernel.org with SMTP id S267591AbUHJQwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:52:38 -0400
Subject: 2.4.27-lck1
From: Eric Hustvedt <lkml@plumlocosoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tkHn2aI1syvJxFTXynwv"
Message-Id: <1092156238.4082.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 12:44:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tkHn2aI1syvJxFTXynwv
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
NTFS file system v2.1.6b

Updated:
- NTFS updated to latest version.

Pending:
- GRsec update to version 2.0.1.
- PPC fixes for the O(1) scheduler and variable hertz.

-Eric

--=-tkHn2aI1syvJxFTXynwv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQBBGPtO8O0ZDXGTPEIRAo2mAJwKy3YTLifvg94yqNvXWffYdSfuiwCYjA38
AnBwvXK/sUAICGWPuVTjEw==
=UU2B
-----END PGP SIGNATURE-----

--=-tkHn2aI1syvJxFTXynwv--

