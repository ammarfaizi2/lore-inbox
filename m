Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbULPV4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbULPV4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbULPV4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:56:03 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:21431 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S262038AbULPVzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:55:51 -0500
Date: Thu, 16 Dec 2004 13:55:45 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: dtor_core@ameritech.net
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org,
       bitkeeper-users@bitmover.com
Subject: Re: bkbits problem?
Message-ID: <20041216215544.GB31805@one-eyed-alien.net>
Mail-Followup-To: dtor_core@ameritech.net,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org,
	bitkeeper-users@bitmover.com
References: <20041216190159.GA31805@one-eyed-alien.net> <200412162116.57509.andrew@walrond.org> <d120d5000412161345420548f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <d120d5000412161345420548f9@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 16, 2004 at 04:45:17PM -0500, Dmitry Torokhov wrote:
> On Thu, 16 Dec 2004 21:16:57 +0000, Andrew Walrond <andrew@walrond.org> w=
rote:
> > On Thursday 16 Dec 2004 19:01, Matthew Dharm wrote:
> > > Is anyone besides me having difficulty cloning a tree from
> > > linux.bkbits.net/linux-2.5 or 2.6?
> > >
> > > I keep getting:
> > >
> > > [mdharm@g5 mdharm]$ bk clone bk://linux.bkbits.net/linux-2.5 linux-40=
5-2.5
> > > Clone bk://linux.bkbits.net/linux-2.5
> > >    -> file://home/mdharm/linux-405-2.5
> > > BAD gzip hdr
> > > read: No such file or directory
> > > 0 bytes uncompressed to 0, nanX expansion
> > > sfio errored
> > >
> > > I can clone from linuxusb, so I don't _think_ it's a problem on my en=
d...
> > >
> >=20
> > I reported the same thing on Sunday to the bitkeeper-users ML (see belo=
w)
> > Interestingly, I can 'pull' to an existing linux-2.5 repo now, but clon=
e is
> > still busted.
>=20
> Try using http for cloning - worked for me last time (bk clone
> http://linux.....)

HTTP is running right now.  The speed leaves something to be desired, but
at least I'm getting a copy of the tree...

It's interesting that it only affects some trees and not others.

For reference, I'm in the USA (California) running on ARCH=3Dppc .

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I'll scuff my feet on the carpet and zap your nose hairs unless you=20
TALK mister!! Who put you up to this?
					-- Pitr
User Friendly, 3/30/1998

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBwgRgIjReC7bSPZARApwsAJ9VJgFh5wpxIqeuUDvF6YN8fUSLpgCfUAT3
AgM6vwcbSokUW6BIFLOMoVE=
=/Qas
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
