Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTKCRCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTKCRCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:02:19 -0500
Received: from D71c0.d.pppool.de ([80.184.113.192]:55206 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S262108AbTKCRCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:02:12 -0500
Subject: Re: Re:No backlight control on PowerBook G4
From: Daniel Egger <degger@fhm.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dustin Lang <dalang@cs.ubc.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1067820334.692.38.camel@gaston>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
	 <1067820334.692.38.camel@gaston>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GtyAFjv2d0hoQhhhJqgK"
Message-Id: <1067878624.7695.15.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 03 Nov 2003 17:57:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GtyAFjv2d0hoQhhhJqgK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mon, den 03.11.2003 schrieb Benjamin Herrenschmidt um 01:45:

> You can't expect a machine just released a couple of weeks ago by
> Apple to be fully supported by linux, do you ? :)

<duckmode>not?</duckmode> ;)

> If it's a new Mobility 9600 machine, then I expect my 2.6 tree
> (bk://ppc.bkbits.net/linuxppc-2.5-benh or rsync from source.mvista.com)
> to work, though the actual backlight "scale" may not be fully correct
> yet.

Interesting, will try. I've a whole bunch of more pressing problems with
my new baby, though. X is completely broken, no matter which X modelines
I configure I get nothing but sizzle on the screen, it seems that the
mode setup for the LVDS with the 9600 Mobility is bork.

The clock scaling of the CPU also doesn't work; interestingly at 867 MHz
it's not much faster the my old Ti PB 500 in dnetc RC-5 though the
overall system has a lot faster design.

Also I cannot boot it automatically from network because holding down N
at bootup will not pick up a DHCP address, so I have to type quite a bit
in OF. :(

If you need any info about the system I'd be glad to help you out.

--=20
Servus,
       Daniel

--=-GtyAFjv2d0hoQhhhJqgK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/pojgchlzsq9KoIYRAlsMAKDT6udRx0HudvqxV7PUgvuXf3p/+QCfbCud
HaF4bRGB1azqliIXzpA/1xw=
=uxPj
-----END PGP SIGNATURE-----

--=-GtyAFjv2d0hoQhhhJqgK--

