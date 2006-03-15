Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWCOOCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWCOOCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 09:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWCOOCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 09:02:46 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:40122 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750745AbWCOOCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 09:02:45 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Ed Sweetman <safemode@comcast.net>
Subject: Re: New libata PATA patch for 2.6.16-rc1
Date: Wed, 15 Mar 2006 15:02:44 +0100
User-Agent: KMail/1.9.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
References: <1142262431.25773.25.camel@localhost.localdomain> <200603151154.15691.prakash@punnoor.de> <4417FA8C.7090106@comcast.net>
In-Reply-To: <4417FA8C.7090106@comcast.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1517234.ZsC91BoSEE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603151502.44586.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1517234.ZsC91BoSEE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch M=E4rz 15 2006 12:29 schrieb Ed Sweetman:
> Prakash Punnoor wrote:
> >Ok, I am having some troubles burning CDs/DVDs. I am using k3b as
> > front-end and it has troubles to detect the type of disc inserted. If y=
ou
> > eg insert a cd-rw the dialog changes the detected medium around (about
> > each second): cd-rom, cd-rw, etc. Same with DVD+R. It detects DVD+R,

[..]
>
> graveman had the same problem.   I went and used cdrecord-prodvd and
> haven't had a problem with direct command line, gcombust, or xcdroast
> (those are all plain frontends to the userspace tools).
>
> This seems to be a userspace problem in operating with libata/pata.
> xcdroast/gcombust and regular commandline usage of cdrecord-prodvd work
> fine.

Ok, thx for the info. I think for the moment I'll go back to the ide driver=
,=20
as I really don't want to use other tools.

=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1517234.ZsC91BoSEE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEGB6ExU2n/+9+t5gRAoQIAJ470ImB+0Ye+Wy9gh5NuGXXJ5OGJACfbODC
SVqHXbfX48wHPHxn4EVhsxQ=
=1dz5
-----END PGP SIGNATURE-----

--nextPart1517234.ZsC91BoSEE--
