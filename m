Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVF2XHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVF2XHI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVF2XHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:07:08 -0400
Received: from mout0.freenet.de ([194.97.50.131]:17365 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S262719AbVF2XFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:05:46 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: Build-in XML support?
Date: Thu, 30 Jun 2005 01:04:54 +0200
User-Agent: KMail/1.8.1
References: <ec2c5c2205062903511d62d6bf@mail.gmail.com> <200506300025.03544.mbuesch@freenet.de> <635171.636ad3ed642208e93e44c79901f90691e930c5afe6b95fe3e707420e71193c0022f01e95.IBX@taniwha.stupidest.org>
In-Reply-To: <635171.636ad3ed642208e93e44c79901f90691e930c5afe6b95fe3e707420e71193c0022f01e95.IBX@taniwha.stupidest.org>
Cc: linux-kernel@vger.kernel.org, Ville Sundell <ville.sundell@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1543881.njzrvRAvYq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506300104.54795.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1543881.njzrvRAvYq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Chris Wedgwood <cw@f00f.org>:
> On Thu, Jun 30, 2005 at 12:25:03AM +0200, Michael Buesch wrote:
>=20
> > Search the archives.
> > There was a thread about this some time ago.
>=20
> that doesn't make it a good idea

I did not say that. Indeed I say it's a bad idea.
And that was also the conclusion in the other thread I talked about.

I only gave this example here, because people often think
xml parsers are big with many lines of code. This one is only
about 500 lines. But still, please don't put such unneccessary
bloat into the kernel. ;)

> > xmlparser.h:
> > http://websvn.kde.org/branches/pwmanager/1.2/pwmanager/pwmanager_dump/x=
mlparser.h?rev=3D416745&view=3Dmarkup
> > xmlparser.c:
> > http://websvn.kde.org/branches/pwmanager/1.2/pwmanager/pwmanager_dump/x=
mlparser.c?rev=3D417577&view=3Dmarkup
>=20
> all this tells me is that some desktop application programmer wants to
> put XML into the kernel

not me. ;)

=2D-=20
Greetings, Michael



--nextPart1543881.njzrvRAvYq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQBCwykWFGK1OIvVOP4RAn9iAJiUxL6QbwDexFex7N10ep+4lltqAJ9vPHau
Sd69mt3deSXJJT64R2trvw==
=IFL1
-----END PGP SIGNATURE-----

--nextPart1543881.njzrvRAvYq--
