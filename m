Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWA2JLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWA2JLq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 04:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWA2JLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 04:11:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:10945 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750759AbWA2JLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 04:11:45 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: get JMicron JMB360 working
Date: Sun, 29 Jan 2006 10:16:26 +0100
User-Agent: KMail/1.9
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060129050434.GA19047@havoc.gtf.org>
In-Reply-To: <20060129050434.GA19047@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1243907.OphOC9yPZf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601291016.30459.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1243907.OphOC9yPZf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag Januar 29 2006 06:04 schrieb Jeff Garzik:

> This patch, against latest 2.6.16-rc-git, adds support for JMicron and
> fixes some code that should be Intel-only, but was being executed for
> all vendors.

Thx, works nicely here with JMicron jMB360 on an Asrock board.

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1243907.OphOC9yPZf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD3IfuxU2n/+9+t5gRAi2bAKCIjpK15ZvjpgsS9c/YH43zvE4XrwCeMRdb
ZnLvUPom94ClXXV21Eu4fFQ=
=3Kmj
-----END PGP SIGNATURE-----

--nextPart1243907.OphOC9yPZf--
