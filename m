Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVDVIu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVDVIu5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 04:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVDVIu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 04:50:57 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:31568 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261924AbVDVIur
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 04:50:47 -0400
From: "Tais M. Hansen" <tais.hansen@osd.dk>
Organization: OSD
To: linux-kernel@vger.kernel.org, Brian Jackson <notiggy@gmail.com>
Subject: Re: SATA/ATAPI
Date: Fri, 22 Apr 2005 10:50:40 +0200
User-Agent: KMail/1.8
References: <200504211941.43889.tais.hansen@osd.dk> <fb20c2140504211651134980d9@mail.gmail.com>
In-Reply-To: <fb20c2140504211651134980d9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1383140.m4pWyQF4FS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504221050.44924.tais.hansen@osd.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1383140.m4pWyQF4FS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 22 April 2005 01:51, Brian Jackson wrote:
> > One of my linux boxes has a Plextor DVD-RW drive with a SATA interface.
> > The kernel sees this drive (ata3) but apparently doesn't tie it to a sdx
> > device. The box also have a SATA harddisk, which is working just fine.
> > The relevant dmesg output is pasted below.
> Just to check, you do have scsi cdrom support enabled right?

Yes. cdrom and sr_mod are both loaded as modules. I'm assuming having compi=
led=20
them as modules doesn't change anything. I'm probably going to try messing=
=20
with the SCSI cdrom driver, just to see if I can figure out what's going on.

=2D-=20
Regards,
Tais M. Hansen
OSD

___________________________________________________________
"If people had understood how patents would be granted when most of today's=
=20
ideas were invented and had taken out patents, the industry would be at a=20
complete standstill today." -Bill Gates (1991)

--nextPart1383140.m4pWyQF4FS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCaLrkLf7B7mQNLngRAnxHAKCWTzgEX7tdVlpOPBP8UZbbp5c98gCgqALx
frIU7xQ0kUMHngi39zhfO8Q=
=Y4Qe
-----END PGP SIGNATURE-----

--nextPart1383140.m4pWyQF4FS--
