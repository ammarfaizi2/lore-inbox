Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267331AbUBSS2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUBSS2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:28:38 -0500
Received: from resin.csoft.net ([63.111.22.86]:63608 "HELO mail231.csoft.net")
	by vger.kernel.org with SMTP id S267331AbUBSS2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:28:37 -0500
Subject: 2.4.25-lck1 (formerly known as the ck patchset)
From: Eric Hustvedt <lkml@plumlocosoft.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zzkYY3IWNpsBXRslTi96"
Message-Id: <1077215318.3402.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Feb 2004 13:28:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zzkYY3IWNpsBXRslTi96
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Updated the lck patchset. I have changed the name so that people don't
confuse the 2.4.x patchset with Con's 2.6.x patchset.

http://www.plumlocosoft.com/kernel/

Includes:
O(1) scheduler with batch scheduling, interactivity
Preemptible kernel
Low Latency
Read Latency2
Variable Hz
64bit jiffies
Supermount-NG v1.2.11a
Bootsplash v3.0.7
POSIX ACL/xattr v0.8.68/0.8.70
NTFS file system v2.1.6a

Added:
- The new NTFS filesystem patches from
http://linux-ntfs.sourceforge.net/ have been incorporated

Updated:
- Supermount-NG updated to latest version.
- POSIX ACLs updated to latest version.

Pending:
- GRsec update

--=-zzkYY3IWNpsBXRslTi96
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBANQBW8O0ZDXGTPEIRAqhJAJ9ACKCAYijZ78+vsCthRBP3hyutVQCfXtFH
w2EGkryvTK/hUvd8GtWX7vs=
=JIsC
-----END PGP SIGNATURE-----

--=-zzkYY3IWNpsBXRslTi96--

