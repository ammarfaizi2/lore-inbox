Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752001AbWJJHwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbWJJHwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbWJJHwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:52:31 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:49305 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1752001AbWJJHwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:52:30 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: "Allen Martin" <AMartin@nvidia.com>
Subject: Re: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
Date: Tue, 10 Oct 2006 09:52:28 +0200
User-Agent: KMail/1.9.4
Cc: "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, jeff@garzik.org
References: <DBFABB80F7FD3143A911F9E6CFD477B018E81719@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B018E81719@hqemmail02.nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1333816.Ofur7ZDYHh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610100952.31913.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1333816.Ofur7ZDYHh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag 10 Oktober 2006 08:44 schrieb Allen Martin:
> > > Unfortunately it doesn't work for me on MCP51 if I change
> >
> > GENERIC to
> >
> > > ADMA. So I wonder whether MCP51 has ADMA mode or what needs
> >
> > to be done
> >
> > > to get NCQ working. :-(
> >

> > If that doesn't provide any insight, maybe the docs Jeff has
> > provide the answer for whether or not the MCP5x/MCP61
> > controllers have the same interface as the CK804/MCP04..
>
> No, only CK804 and MCP04 support ADMA.  We'll be publishing some patches
> for NCQ support for MCP55/MCP61 soon.

That's great news! I hope you don't forget the MCP51, as well, as you didn'=
t=20
mention it. :-)
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1333816.Ofur7ZDYHh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFK1E/xU2n/+9+t5gRAhBeAJ9VnJ99I6uNesna0uXF2nGukCgKEQCgx8Gp
JC9wmOtyDgasbUBPjDLKX3U=
=Oirh
-----END PGP SIGNATURE-----

--nextPart1333816.Ofur7ZDYHh--
