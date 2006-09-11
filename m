Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWIKKei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWIKKei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 06:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWIKKei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 06:34:38 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:60057 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750725AbWIKKei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 06:34:38 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Thomas Richter <thor@mail.math.tu-berlin.de>
Subject: Re: Sensors on Asus M2N SLI Deluxe
Date: Mon, 11 Sep 2006 12:34:25 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200609110927.k8B9RJfH019016@mersenne.math.TU-Berlin.DE>
In-Reply-To: <200609110927.k8B9RJfH019016@mersenne.math.TU-Berlin.DE>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2107832.2zzQJ15rBk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609111234.25413.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2107832.2zzQJ15rBk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag 11 September 2006 11:27 schrieb Thomas Richter:
> Hi folks,
>
> aparently the 2.6.17.8 kernel or rather the lm_sensors package which is
> part of this kernel does not recognize the on-board chips of this
> motherboard correctly.

Take a look into lm_sensors ml. Some patches have been posted, which work w=
ell=20
for me with 2.6.18rc. (I have a slightly different mobo, but I guess the sa=
me=20
it87 derivative is used on yours.) The will probably go into 2.6.19, IIRC.

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2107832.2zzQJ15rBk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFBTuxxU2n/+9+t5gRAq3GAKDj4+tOVexfn7xsPiWc3RIhkJMsWgCeL2gE
19LEqwQJ+Miq3T2ONa7w4tU=
=aw8c
-----END PGP SIGNATURE-----

--nextPart2107832.2zzQJ15rBk--
