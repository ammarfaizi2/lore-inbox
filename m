Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWJQWU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWJQWU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWJQWU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:20:56 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:22237 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750762AbWJQWUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:20:55 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: VCD not readable under 2.6.18
Date: Wed, 18 Oct 2006 00:21:08 +0200
User-Agent: KMail/1.9.5
Cc: wixor <wixorpeek@gmail.com>, linux-kernel@vger.kernel.org
References: <c43b2e150610161153x28fef90bw4922f808714b93fd@mail.gmail.com> <c43b2e150610171116w2d13e47ancbea07c09bd5ffbf@mail.gmail.com> <1161124732.5014.20.camel@localhost.localdomain>
In-Reply-To: <1161124732.5014.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1167250.aOVnX8kSQE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610180021.09077.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1167250.aOVnX8kSQE
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch 18 Oktober 2006 00:38 schrieb Alan Cox:
> Now where it all gets weirder is that some forms of VCD (especially the
> ones for philips short lived interactive stuff) have an ISO file system
> on them but where sector numbers in the file system for video blocks
> point to blocks that are not 2K data blocks but mpeg blocks that the
> file system layer can't handle, so a VCD disk can appear mountable and
> the like.

Perhaps I confuse things with SVCDs, but the ISO part *should* actually be=
=20
mountable as it could contain valid data. I remeber authorinhg such disks=20
(ie, puttins some stuff into the ISO part), which worked nicely, ie. it pla=
ys=20
fine in standalone and eg. in Windows I could also access data on the ISO f=
s.

PS: Could you please check your clock. My mailer gets confused as your mail=
s=20
seem to come 20 minutes from the future. ;-)

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1167250.aOVnX8kSQE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFNVdVxU2n/+9+t5gRAtzhAJwL37KKwXj3+j3ha8cj4Of3ndb5IgCg5pzg
ocl6jEUFsvb5gBqw2YrB7ig=
=w0G3
-----END PGP SIGNATURE-----

--nextPart1167250.aOVnX8kSQE--
