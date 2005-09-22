Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbVIVSTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVIVSTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 14:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbVIVSTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 14:19:08 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:45213 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1750951AbVIVSTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 14:19:06 -0400
Date: Thu, 22 Sep 2005 20:19:03 +0200
From: Harald Welte <laforge@netfilter.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update Documentation/sparse.txt
Message-ID: <20050922181903.GQ26520@sunbeam.de.gnumonks.org>
References: <20050921170539.GA10537@mipter.zuzino.mipt.ru> <20050922132833.GM26520@sunbeam.de.gnumonks.org> <20050922153451.GA7519@mipter.zuzino.mipt.ru> <20050922170009.GP26520@sunbeam.de.gnumonks.org> <Pine.LNX.4.58.0509221008100.20059@shark.he.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IihjUyvzd0n5Ehsu"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509221008100.20059@shark.he.net>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IihjUyvzd0n5Ehsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2005 at 10:09:45AM -0700, Randy.Dunlap wrote:
> Please leave Dave's snapshots dir. there even if you add the git method.
> It is still present and working.
> Thanks.

MH. I tried the URL and it didn't work at that time.  Apparently I had a
typo or something like that.

Sorry.

Pleae see below

[DOCUMENTATION] sparse no longer uses bk, but git

Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit 22a1c0f5333d3701a48eb80bf03ca54c53384f25
tree 89c4250c5eeebc2ab41bc1df905f269a7a233374
parent 0410f33b62b892379270539b189577126ea56ffe
author Harald Welte <laforge@netfilter.org> Do, 22 Sep 2005 20:18:03 +0200
committer Harald Welte <laforge@netfilter.org> Do, 22 Sep 2005 20:18:03 +02=
00

 Documentation/sparse.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sparse.txt b/Documentation/sparse.txt
--- a/Documentation/sparse.txt
+++ b/Documentation/sparse.txt
@@ -51,9 +51,9 @@ or you don't get any checking at all.
 Where to get sparse
 ~~~~~~~~~~~~~~~~~~~
=20
-With BK, you can just get it from
+With git, you can just get it from
=20
-        bk://sparse.bkbits.net/sparse
+        rsync://rsync.kernel.org/pub/scm/devel/sparse/sparse.git
=20
 and DaveJ has tar-balls at
=20
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--IihjUyvzd0n5Ehsu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMvWXXaXGVTD0i/8RAu5mAKCIuNEYVTaYMUUgvWFniPoorl2aywCgpAD5
8kbFS8UHSd9oR+RN7dRLSqE=
=zfsH
-----END PGP SIGNATURE-----

--IihjUyvzd0n5Ehsu--
