Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWBJQnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWBJQnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWBJQnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:43:20 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:12751 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751302AbWBJQnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:43:18 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Marc Perkel <marc@perkel.com>
Subject: Re: ata1: command 0x35 timeout sata_nv driver
Date: Fri, 10 Feb 2006 17:43:16 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <43ECB9EA.9000804@perkel.com> <200602101730.47512.prakash@punnoor.de> <43ECC05D.6010901@perkel.com>
In-Reply-To: <43ECC05D.6010901@perkel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4957014.tKUAa9V1os";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602101743.16821.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4957014.tKUAa9V1os
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag Februar 10 2006 17:33 schrieb Marc Perkel:
> Prakash Punnoor wrote:
> > Am Freitag Februar 10 2006 17:06 schrieb Marc Perkel:
> >> Are there still problems with sata_nv?
> >>
> >> Running 2 maxtor 250gig drives with 16mb buffer.
> >>
> >> Getting this error:
> >> ata1: command 0x35 timeout, stat 0x50 hos_stat 0x24
> >> ata2: command 0x35 timeout, stat 0x50 hos_stat 0x24
> >
> > Maxtor released a new BIOS fixing issues with nforce4. Maybe you want to
> > ask bios for the fw and test it?
>
> So I update the drive bios? Where do I find that? Thanks for your help.

Ask Maxtor.

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart4957014.tKUAa9V1os
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD7MKkxU2n/+9+t5gRApo+AJ4l9v5PW65FLXmJ3BAAwNP9X1zu5gCg8pTu
ayFMfQ6ZJGEnsC7stkm6u5A=
=3y4q
-----END PGP SIGNATURE-----

--nextPart4957014.tKUAa9V1os--
