Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVCTU6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVCTU6g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 15:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVCTU6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 15:58:36 -0500
Received: from downeast.net ([204.176.212.2]:34010 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261280AbVCTU6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 15:58:32 -0500
From: Patrick McFarland <pmcfarland@downeast.net>
To: linux-kernel@vger.kernel.org
Subject: alsa es1371's joystick functionality broken in 2.6.11-mm4
Date: Sun, 20 Mar 2005 15:57:52 -0500
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1461841.ekimFRJ5FC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503201557.58055.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1461841.ekimFRJ5FC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

It seems that the es1371 driver (which provides its own joystick port drive=
r)=20
is broken in at least 2.6.11-mm4. I don't know when it broke, but it used t=
o=20
work around in the 2.6.8/9 days (I haven't used the joystick in awhile). Th=
e=20
hardware and joystick still both work (tested in Windows).

Where do I go from here?

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart1461841.ekimFRJ5FC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCPePV8Gvouk7G1cURAgjFAJ0QYKkwHSTTiaA3HHRPy2p8Vm+mAgCgo0zh
INd/d6uL2ziLehdM7K62Kxk=
=jAJ5
-----END PGP SIGNATURE-----

--nextPart1461841.ekimFRJ5FC--
