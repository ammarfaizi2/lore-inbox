Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbTGDThy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbTGDThy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:37:54 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:65286 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S266138AbTGDThv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:37:51 -0400
Date: Fri, 4 Jul 2003 12:52:17 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, torvalds@osdl.org
Subject: Re: scsi mode sense broken again
Message-ID: <20030704125217.A17588@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, torvalds@osdl.org
References: <UTC200307032306.h63N6HQ26283.aeb@smtp.cwi.nl> <20030703171053.A3254@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030703171053.A3254@one-eyed-alien.net>; from mdharm-kernel@one-eyed-alien.net on Thu, Jul 03, 2003 at 05:10:53PM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2003 at 05:10:53PM -0700, Matthew Dharm wrote:
> On Fri, Jul 04, 2003 at 01:06:17AM +0200, Andries.Brouwer@cwi.nl wrote:
> > For me 2.5.72 works, 2.5.74 does not - no working ZIP drive.
> > The cause is the recent fiddling of use_10 / do_mode_sense.
> > If this is known and has a patch on the way all is well.
> > Otherwise I can send a patch.
>=20
> Really?  I expected bug reports for CD-ROM, but not for Direct Access
> devices.  What's going bad?

I just did some re-testing, and my self-powered Zip250 and Zip750 work.
The 750 takes a few seconds to initialize, but nothing really bad.

What Zip do you have that doesn't work?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Somebody call an exorcist!
					-- Dust Puppy
User Friendly, 5/16/1998

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/BdrxIjReC7bSPZARAjxLAJ983eLOdC83CGQBcNIInL+6jn1yAACfUvXO
PE3KKICaMYcbBKmORDPl4bM=
=YqmB
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
