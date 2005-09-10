Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVIJPUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVIJPUZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 11:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVIJPUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 11:20:25 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:56041 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1750982AbVIJPUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 11:20:24 -0400
Date: Sun, 11 Sep 2005 01:20:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: asm-offsets.h is generated in the source tree
Message-Id: <20050911012033.5632152f.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__11_Sep_2005_01_20_33_+1000_yAulPjZAGtgL1Skq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__11_Sep_2005_01_20_33_+1000_yAulPjZAGtgL1Skq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The latest Linus-git tree generates asm-offsets.h in the source tree even
if you use O=3D... I don't know how to fix this, but it means that the
source tree cannot be read only.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__11_Sep_2005_01_20_33_+1000_yAulPjZAGtgL1Skq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDIvnJFdBgD/zoJvwRAgX1AJ0dPQ5v/mAiLnOP4RDDh3fAMuIWBwCgiUC1
ijpwtx/u6hIR2VVmvGlwUmA=
=o7D1
-----END PGP SIGNATURE-----

--Signature=_Sun__11_Sep_2005_01_20_33_+1000_yAulPjZAGtgL1Skq--
