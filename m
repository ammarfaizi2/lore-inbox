Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWJGJmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWJGJmb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 05:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWJGJmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 05:42:31 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:31156 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750718AbWJGJma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 05:42:30 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
Date: Sat, 7 Oct 2006 11:42:22 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       jeff@garzik.org
References: <45276085.3040102@shaw.ca>
In-Reply-To: <45276085.3040102@shaw.ca>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2475260.ipCucWDon7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610071142.26045.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2475260.ipCucWDon7
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Samstag 07 Oktober 2006 10:08 schrieb Robert Hancock:
> I've been working on the patch for sata_nv ADMA support for nForce4 that

Nice!

> make the default 1). I only enabled ADMA on those chipsets and not
> MCP51, MCP55 or MCP61 since that was all that the original NVIDIA
> version did. I assume there was a reason for this, though maybe not.

Unfortunately it doesn't work for me on MCP51 if I change GENERIC to ADMA. =
So=20
I wonder whether MCP51 has ADMA mode or what needs to be done to get NCQ=20
working. :-(

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2475260.ipCucWDon7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFJ3aCxU2n/+9+t5gRAoDRAJ0ctnr4CyVqEYnN23ykofmTBp9cdACeO01/
qzMiEmZE++FDREwC538Sm1g=
=9nOU
-----END PGP SIGNATURE-----

--nextPart2475260.ipCucWDon7--
