Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270937AbTGPQMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270936AbTGPQMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:12:08 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:8211 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S270946AbTGPQMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:12:03 -0400
Date: Wed, 16 Jul 2003 09:26:43 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: e1000 with 82546EB parts on 2.4?
Message-ID: <20030716092643.B17580@one-eyed-alien.net>
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Kernel Developer List <linux-kernel@vger.kernel.org>
References: <20030715001654.D25443@one-eyed-alien.net> <Pine.LNX.4.53.0307150312250.32541@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.53.0307150312250.32541@montezuma.mastecende.com>; from zwane@arm.linux.org.uk on Tue, Jul 15, 2003 at 03:13:31AM -0400
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2003 at 03:13:31AM -0400, Zwane Mwaikambo wrote:
> On Tue, 15 Jul 2003, Matthew Dharm wrote:
>=20
> > What I've got is your basic x86 machine with an Intel 82546EB dual-GigE
> > controller on a PCI bus.  I load e1000.o, ifconfig, and I'm running.  T=
he
> > interface is solid as a rock, AFAICT.  I've left it running for days
> > without any problems.
> >=20
> > However, if I ifdown and then ifup the interface, I'm borked.  Based on
> > tcpdump from another machine, the interface is definately transmitting
> > packets just fine.  But, it never seems to notice any packets on the
> > receive side.
>=20
> Does unloading and reloading the module 'fix' things?

Only sometimes.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I'm just trying to think of a way to say "up yours" without getting fired.
					-- Stef
User Friendly, 10/8/1998

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/FXzCIjReC7bSPZARAs5tAKCTELymWIRz72+3DLpuyWVd35oFSACfUK9+
1dodzAbfd202KH9LO36cYLA=
=ehjg
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
