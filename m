Return-Path: <linux-kernel-owner+w=401wt.eu-S1760732AbWLHOEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760732AbWLHOEv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 09:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760733AbWLHOEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 09:04:51 -0500
Received: from mail.goelsen.net ([195.202.170.130]:39377 "EHLO
	power2u.goelsen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760732AbWLHOEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 09:04:50 -0500
X-Envelope-From: michael.monnerie@it-management.at
X-Envelope-From: michael.monnerie@it-management.at
From: Michael Monnerie <michael.monnerie@it-management.at>
Organization: it-management http://it-management.at
To: linux-kernel@vger.kernel.org
Subject: BUG: Forcedeth & bonding stops working in 2.6.19
Date: Fri, 8 Dec 2006 15:04:28 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1203387.pVCy7Xafg5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200612081504.31803@zmi.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1203387.pVCy7Xafg5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello, I currently use 2.6.18.3 with bonding over two forcedeth network=20
cards, works pretty well (Asus M32N mainboard, AMD dual core).

I wanted to switch to 2.6.19, but found that - despite it doesn't show=20
any errors - the network stops responding shortly after boot. So I went=20
back on 2.6.18.3, which has no problems.

In case you need more info on hardware, or testing of patches, please=20
write me directly, I'm not on this list. Thank you.

mfg zmi
=2D-=20
// Michael Monnerie, Ing.BSc    -----      http://it-management.at
// Tel: 0676/846914666                        .network.your.ideas.
// PGP Key:        "curl -s http://zmi.at/zmi3.asc | gpg --import"
// Fingerprint: 44A3 C1EC B71E C71A B4C2  9AA6 C818 847C 55CB A4EE
// Keyserver: www.keyserver.net                 Key-ID: 0x55CBA4EE

--nextPart1203387.pVCy7Xafg5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFeXDvyBiEfFXLpO4RAnO4AJ4+svVEhvafTeXMpKUltpSdru7itACfX3vH
wVXgqJUlDxHz/wc0T1hxZEE=
=9JNK
-----END PGP SIGNATURE-----

--nextPart1203387.pVCy7Xafg5--
