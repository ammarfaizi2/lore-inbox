Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbULPTIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbULPTIn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbULPTFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:05:22 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:52146 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261980AbULPTCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:02:01 -0500
Date: Thu, 16 Dec 2004 11:01:59 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: bkbits problem?
Message-ID: <20041216190159.GA31805@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Is anyone besides me having difficulty cloning a tree from
linux.bkbits.net/linux-2.5 or 2.6?

I keep getting:

[mdharm@g5 mdharm]$ bk clone bk://linux.bkbits.net/linux-2.5 linux-405-2.5
Clone bk://linux.bkbits.net/linux-2.5
   -> file://home/mdharm/linux-405-2.5
BAD gzip hdr
read: No such file or directory
0 bytes uncompressed to 0, nanX expansion
sfio errored

I can clone from linuxusb, so I don't _think_ it's a problem on my end...

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBwdunIjReC7bSPZARAoJQAKCuVHszAWGXCRnorUE+KK1ItqbDIwCgo6mk
XDJwKJfI7/if7GFLTSAVoX4=
=d+d3
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
