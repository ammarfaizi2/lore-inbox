Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262962AbTDBLGn>; Wed, 2 Apr 2003 06:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262967AbTDBLGm>; Wed, 2 Apr 2003 06:06:42 -0500
Received: from host217-36-80-42.in-addr.btopenworld.com ([217.36.80.42]:31921
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S262962AbTDBLGk>; Wed, 2 Apr 2003 06:06:40 -0500
Subject: Re: 2.5 Kernel Framebuffer Problems
From: Matthew Hall <matt@ecsc.co.uk>
To: mtangolics@rcn.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E190QXQ-0004Uz-00@smtp01.mrf.mail.rcn.net>
References: <E190QXQ-0004Uz-00@smtp01.mrf.mail.rcn.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5Gkqs7jUBqM9FG5r2Fj6"
Organization: ECSC Ltd.
Message-Id: <1049282302.745.24.camel@sheeta>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (Preview Release)
Date: 02 Apr 2003 12:18:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5Gkqs7jUBqM9FG5r2Fj6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-04-01 at 19:31, mtangolics@rcn.com wrote:
> I've had a couple of problems with framebuffer console, when=20
> compiling several different versions of the 2.5 kernel.  I=20
> included all the FB support, but when I boot up using, LILO=20
> option, vga=3D791 or anything about normal, the screen either=20
> goes black, and the system stops responding or the entire=20
> screen becomes scrambled.  I have an NVidia Geforce4 video=20
> card if that matters.  I've talked to a couple other users=20
> who have encountered the same problem.  It's most likely just=20
> a stupid mistake on my part, but any help would be extremely=20
> appreciated.

What does your lilo.conf line for 2.5 look like?
You may need to append some video information, eg.

append=3D"video=3Drivafb,xres:1024,yres:768,bpp:8"

Matt
--=20
- -- --- ---- .                                   .---- --- -- -
Matthew Hall   \ http://people.ecsc.co.uk/~matt/ /
matt@ecsc.co.uk '-------------------------------'

Sig: Destiny is a good thing to accept when it's going your way. When it is=
n't, don't call it destiny; call it injustice, treachery, or simple bad luc=
k. -- Joseph Heller, "God Knows"

- -- --- ---- ------------------------------------ ---- --- -- -
PGP/GnuPG Key: 1024D/2EABF3D5
Fingerprint: AA89 2BEE FC42 5D64 8CA0  B325 C39C 53E5 2EAB F3D5
http://people.ecsc.co.uk/~matt/files/mattatecscdotcodotuk.asc
- -- --- ---- ------------------------------------ ---- --- -- -

--=-5Gkqs7jUBqM9FG5r2Fj6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+isb9w5xT5S6r89URAocZAJ9cOzXXlSJw4GKfJuShq8oU1YUr3gCdHHOa
yzG49QbuaH85lkfuj0CauPY=
=sSRq
-----END PGP SIGNATURE-----

--=-5Gkqs7jUBqM9FG5r2Fj6--

