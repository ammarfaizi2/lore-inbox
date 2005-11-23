Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVKWUex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVKWUex (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVKWUcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:32:53 -0500
Received: from www.paintingsonsilence.com ([192.136.111.56]:1942 "EHLO
	mises.celestial.com") by vger.kernel.org with ESMTP id S932364AbVKWUaI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:30:08 -0500
From: Douglas J Hunley <doug@hunley.homeip.net>
To: linux-kernel@vger.kernel.org
Subject: stupid question about netlink and 2.6.14 and latest udev
Date: Wed, 23 Nov 2005 15:29:28 -0500
User-Agent: KMail/1.8.3
X-Face: -Zh%*dD|fT[a]YH:6KQ&FF3Q|I@=?utf-8?q?g4JVj-bo=5E=5EV=3B=235-6e0NIry=26/v=6058=3BL+w=3Ac9+=5CgJ=27TL=5B?=
 =?utf-8?q?=0A=09=7EO=7Dc6=7Dc?=,!8tEb%oT1XDn+`3HU>*&s{tLo69vAo0sLuFf8$34|WAM!+vo/[~+%JudP?K6,
 =?utf-8?q?4=0A=09=26K=7D=3D=7EjI62=5DJ7pa1E=25=7E1PrWhOxaofcEJ=7BvyC=3D2f?=
 =?utf-8?q?4SPK7dlyp?=,m>;]@%x#N&q0)$:|qW&
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1341212.ulfdUpSRBU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511231529.55683.doug@hunley.homeip.net>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.1 (doug.hunley.homeip.net [0.0.0.0]); Wed, 23 Nov 2005 15:30:00 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1341212.ulfdUpSRBU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Latest udev says that it requires netlink support in the kernel, however I=
=20
can't find any concrete info on how to enable netlink in 2.6.14+ .. a grep =
of=20
NETLINK in .config doesn't find anything. I saw an option that made referen=
ce=20
to netlink, but it didn't actually state that it was enabling netlink. What=
's=20
the magic config option? Or how does one check if a running kernel has=20
netlink support functional?
thanks!
=2D-=20
Douglas J Hunley (doug at hunley.homeip.net) - Linux User #174778

I'm not worried. If there's something bad out there we'll find, you'll slay=
,=20
we'll party!

--nextPart1341212.ulfdUpSRBU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDhNFDsYn2tNI6QcgRApCnAJ0eMxUHWphVqpmy1Z2dvLgVzXt5yACgn5BU
n+ptUOMmJOpTTcYsXf8ldYk=
=CiW+
-----END PGP SIGNATURE-----

--nextPart1341212.ulfdUpSRBU--
