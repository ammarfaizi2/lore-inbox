Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUHUVFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUHUVFO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267924AbUHUVFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:05:11 -0400
Received: from mylinuxtime.de ([217.160.170.124]:46494 "EHLO solar.linuxob.de")
	by vger.kernel.org with ESMTP id S267921AbUHUVDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:03:13 -0400
From: Christian Hesse <mail@earthworm.de>
To: linux-kernel@vger.kernel.org
Subject: v2.6.8.1 breaks tspc
Date: Sat, 21 Aug 2004 23:02:58 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5980551.3zAr7Qn1pi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408212303.05143.mail@earthworm.de>
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.27.0.6; VDF 6.27.0.23
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5980551.3zAr7Qn1pi
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello!

Kernel version 2.6.8.1 breaks tspc (Freenet6's Tunnel Server Protocol Clien=
t).=20
It tries to connect to the server but waits forever. No problems with 2.6.7=
,=20
booted the old kernel and it worked perfectly.

Any ideas?

Please CC.

=2D-=20
Christian

--nextPart5980551.3zAr7Qn1pi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBJ7iJlZfG2c8gdSURAtOrAKDGQYCn2iLMJUo6Fa7UOdHYbttW7QCfUcCQ
Y6y/sxR1P5XeE7nRpxlAfIo=
=r9ci
-----END PGP SIGNATURE-----

--nextPart5980551.3zAr7Qn1pi--
