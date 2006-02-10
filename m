Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWBJQbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWBJQbG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWBJQbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:31:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:35560 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932157AbWBJQbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:31:04 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Marc Perkel <marc@perkel.com>
Subject: Re: ata1: command 0x35 timeout sata_nv driver
Date: Fri, 10 Feb 2006 17:30:42 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <43ECB9EA.9000804@perkel.com>
In-Reply-To: <43ECB9EA.9000804@perkel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1139591323.nPI5Mfr6lf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602101730.47512.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1139591323.nPI5Mfr6lf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag Februar 10 2006 17:06 schrieb Marc Perkel:
> Are there still problems with sata_nv?
>
> Running 2 maxtor 250gig drives with 16mb buffer.
>
> Getting this error:
> ata1: command 0x35 timeout, stat 0x50 hos_stat 0x24
> ata2: command 0x35 timeout, stat 0x50 hos_stat 0x24

Maxtor released a new BIOS fixing issues with nforce4. Maybe you want to as=
k=20
bios for the fw and test it?

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1139591323.nPI5Mfr6lf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD7L+3xU2n/+9+t5gRAhxSAKCy25xW/fzEBqc/n7jFRnYcr99trwCg9XPH
XcU1J0J/eFyb1XwJpMNbAho=
=CpIj
-----END PGP SIGNATURE-----

--nextPart1139591323.nPI5Mfr6lf--
