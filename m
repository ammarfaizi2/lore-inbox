Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWIQUDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWIQUDf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 16:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWIQUDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 16:03:35 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:53712 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S932385AbWIQUDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 16:03:34 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: "Gerd v. Egidy" <lists@egidy.de>
Subject: Re: APIC on Asus M2N SLI Deluxe
Date: Sun, 17 Sep 2006 22:03:14 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Thomas Richter <thor@mail.math.tu-berlin.de>
References: <200609141017.k8EAHdL9017691@mersenne.math.TU-Berlin.DE> <200609172121.44566.lists@egidy.de>
In-Reply-To: <200609172121.44566.lists@egidy.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1550981.5qx8YFE7io";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609172203.18666.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1550981.5qx8YFE7io
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag 17 September 2006 21:21 schrieb Gerd v. Egidy:
> Hi Thomas,
>
> > recently, I tried to upgrade the bios of the ASUS M2N SLI Deluxe
> > board from release 0202 to 0307. With the 0307 bios, I get a kernel
> > panic that the APIC cannot be found. Concerning this, I've two
> > explanations, could possibly confirm someone here this:
>
> I can confim this problem.

Does it boot with no_timer_check boot parameter?
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1550981.5qx8YFE7io
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFDaoGxU2n/+9+t5gRApG+AJ0QYPr7OLHQ8uJNtj7yl1ROh/JdHgCeNp1l
3i2mLw506yNc28CTKyiBQpw=
=SFol
-----END PGP SIGNATURE-----

--nextPart1550981.5qx8YFE7io--
