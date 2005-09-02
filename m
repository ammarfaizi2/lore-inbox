Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbVIBHEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbVIBHEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 03:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbVIBHEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 03:04:22 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:6064 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030478AbVIBHEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 03:04:21 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] driverfs is dead
Date: Fri, 2 Sep 2005 08:56:25 +0200
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1351435.l5iuXUFrFU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509020856.33213@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1351435.l5iuXUFrFU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This little patch series removes some references to driverfs, which is call=
ed=20
sysfs for a long time.

No code changes, this is all in comments. Please apply,

Eike

--nextPart1351435.l5iuXUFrFU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDF/ehXKSJPmm5/E4RAitfAKCjojIcWhaDnIAOH8Yo/sP0wdb48QCfZVOa
NryZ5Wnq91Dnt2g2PnjihtQ=
=eq0v
-----END PGP SIGNATURE-----

--nextPart1351435.l5iuXUFrFU--
