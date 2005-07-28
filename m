Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVG1Rt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVG1Rt5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVG1Rpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:45:54 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:64696 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261773AbVG1Rnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:43:47 -0400
Date: Thu, 28 Jul 2005 19:43:34 +0200
From: Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc3-mm3 question
Message-Id: <20050728194334.4f5b3f22.astralstorm@gorzow.mm.pl>
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__28_Jul_2005_19_43_34_+0200_XNG21IXL2F8WyS3P"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__28_Jul_2005_19_43_34_+0200_XNG21IXL2F8WyS3P
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I wonder which git version is linus.patch updating to, as it certainly isn't
the mostly new git/hg tree (sans ALSA tree merge), as one patch didn't appl=
y cleanly.
(sched-consider-migration-thread-with-smp-nice.patch)
It could be written as a comment, if that's not too hard to do.

What about releasing a secret release just right before -mm in order to avo=
id
problems like that MTRR problem?
--=20
AstralStorm

GPG Key ID =3D 0xD1F10BA2
GPG Key fingerprint =3D 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2
Please encrypt if you can.

--Signature=_Thu__28_Jul_2005_19_43_34_+0200_XNG21IXL2F8WyS3P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQFC6RlMlUMEU9HxC6IRAr/mAJ4w5chwT0XvWmrlA6S+FrWcv/M0WgCdHIe0
/N72y9D/Af1yiseuX/aUjI8=
=WycF
-----END PGP SIGNATURE-----

--Signature=_Thu__28_Jul_2005_19_43_34_+0200_XNG21IXL2F8WyS3P--
