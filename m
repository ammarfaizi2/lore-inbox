Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbUAISxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUAISxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:53:52 -0500
Received: from absinthe.ifi.unizh.ch ([130.60.75.58]:42632 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP id S263587AbUAISxu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:53:50 -0500
Date: Fri, 9 Jan 2004 19:53:48 +0100
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: stability problems with 2.4.24/Software RAID/ext3
Message-ID: <20040109185348.GA24499@piper.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040108151225.GA11740@piper.madduck.net> <1073671862.24706.13.camel@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <1073671862.24706.13.camel@tux.rsn.bth.se>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.0-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Martin Josefsson <gandalf@wlug.westbo.se> [2004.01.09.1911 +010=
0]:
> Try replacing the Promise controllers with something diffrent (doesn't
> really matter what).

Well, I can't find any other suitable ones, really. I can't seem to
find HighPoints, there is 3ware and DawiControl, but I don't know
which ones are supported by Linux.

Maybe someone can give me a suggestion for a non-promise EIDE 133
PCI controller that's natively supported by Linux.

> I personally have a pdc20267 in my workstation that I stress quite
> heavily sometimes and I've never had any problems with it.

that's a different driver. so it might be the driver that's causing
the problems. if i replace the controller, i may be able to debug,
but unless i get a new controller in place, i can't do anything
since this is a productive machine.

thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
micro$oft could shit in a box, and most people would buy it.

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE//vi8IgvIgzMMSnURAkC3AKDsHZoagPwkjKRhMcLfUQngboq6MACghuD2
LGy9AnkA78GgD2PDf8lCUfU=
=b+k+
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
