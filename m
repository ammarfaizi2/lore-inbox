Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWJENR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWJENR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWJENR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:17:28 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:26064 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751460AbWJENR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:17:28 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.19-rc1: PATA long delay with AMD driver on init
Date: Thu, 5 Oct 2006 15:17:19 +0200
User-Agent: KMail/1.9.4
Cc: Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200610050930.10231.prakash@punnoor.de> <1160054417.1607.8.camel@localhost.localdomain>
In-Reply-To: <1160054417.1607.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1687560.H6AjgDQ9Yl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610051517.19655.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1687560.H6AjgDQ9Yl
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag 05 Oktober 2006 15:20 schrieb Alan Cox:
> Ar Iau, 2006-10-05 am 09:30 +0200, ysgrifennodd Prakash Punnoor:
> > Hi,
> >
> > I tried the PATA driver for my onboard IDE with one DVD+RW drive
> > connected as master. The driver hangs a long time on probing
>
> That is sort fo expected for some AMD variants right now as they don't
> all have enable bits. Once Tejun's work on drive discovery is in I'll
> probably enable it for all PATA chips and that ought to sort it out

Hmm, OK, is is possible to prevent probing the slave by kernel paramter?
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1687560.H6AjgDQ9Yl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFJQXfxU2n/+9+t5gRAv+AAKCCuE5Or2wkRaYw9OWYMXoOROzj2ACfUvuh
I0w9iBkJ+sWeqD1Us3Nea4w=
=POto
-----END PGP SIGNATURE-----

--nextPart1687560.H6AjgDQ9Yl--
