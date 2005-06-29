Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVF2W0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVF2W0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVF2W0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:26:54 -0400
Received: from mout1.freenet.de ([194.97.50.132]:53650 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S262691AbVF2W0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:26:50 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: Build-in XML support?
Date: Thu, 30 Jun 2005 00:25:03 +0200
User-Agent: KMail/1.8.1
References: <ec2c5c2205062903511d62d6bf@mail.gmail.com> <715093.8e23073dd5b3768051865c10fd31f542c39a3531079809488fc0f500cacb255a2afd49c2.ANY@taniwha.stupidest.org>
In-Reply-To: <715093.8e23073dd5b3768051865c10fd31f542c39a3531079809488fc0f500cacb255a2afd49c2.ANY@taniwha.stupidest.org>
MIME-Version: 1.0
Message-Id: <200506300025.03544.mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, Ville Sundell <ville.sundell@gmail.com>
Content-Type: multipart/signed;
  boundary="nextPart3604740.eQRd2bMra9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3604740.eQRd2bMra9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Chris Wedgwood <cw@f00f.org>:
> On Wed, Jun 29, 2005 at 01:51:06PM +0300, Ville Sundell wrote:
>=20
> > I know, this maybe is F.A.Q, but I ask it anyway (because I have not fo=
und it
> > in kernel mail-list, so don't shot me!):
>=20
> <bang>
>=20
> > How about build-in XML-support to kernel?
>=20
> What problem is this solving?
>=20
> > Good or bad?
>=20
> Utterly pointless
>=20
> > It would be wery useful for config-files?
>=20
> The kernel doesn't have config files, just knobs in proc/sysfs.
>=20
> > (...and I have a draft for small XML-parser in C-language;) )

Search the archives.
There was a thread about this some time ago.
Tim Hockin talked about his XML parser there. I'm currently
using it (in a modified form) in some of my programs:

xmlparser.h:
http://websvn.kde.org/branches/pwmanager/1.2/pwmanager/pwmanager_dump/xmlpa=
rser.h?rev=3D416745&view=3Dmarkup
xmlparser.c:
http://websvn.kde.org/branches/pwmanager/1.2/pwmanager/pwmanager_dump/xmlpa=
rser.c?rev=3D417577&view=3Dmarkup

Sorry for the half-offtopic posting. :D

=2D-=20
Greetings, Michael



--nextPart3604740.eQRd2bMra9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCwx+/FGK1OIvVOP4RAk7pAKCCyPyIseeRIUrPzBQ9hjmRrJN97QCfY9T/
YdlPmnaHs0q6Dd8Ni9YIoF4=
=R7J2
-----END PGP SIGNATURE-----

--nextPart3604740.eQRd2bMra9--
