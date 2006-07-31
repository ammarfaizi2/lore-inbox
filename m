Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbWGaT3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbWGaT3G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWGaT3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:29:06 -0400
Received: from lug-owl.de ([195.71.106.12]:28853 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030351AbWGaT3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:29:05 -0400
Date: Mon, 31 Jul 2006 21:29:03 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Clay Barnes <clay.barnes@gmail.com>
Cc: Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060731192902.GS31121@lug-owl.de>
Mail-Followup-To: Clay Barnes <clay.barnes@gmail.com>,
	Rudy Zijlstra <rudy@edsons.demon.nl>,
	Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
	ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
	jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl> <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org> <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731162224.GJ31121@lug-owl.de> <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl> <20060731173239.GO31121@lug-owl.de> <20060731181120.GA9667@merlin.emma.line.org> <20060731184314.GQ31121@lug-owl.de> <20060731191712.GE17206@HAL_5000D.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r3KnbM2MoJFBL7Dl"
Content-Disposition: inline
In-Reply-To: <20060731191712.GE17206@HAL_5000D.tc.ph.cox.net>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r3KnbM2MoJFBL7Dl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-31 12:17:12 -0700, Clay Barnes <clay.barnes@gmail.com> wrot=
e:
> On 20:43 Mon 31 Jul     , Jan-Benedict Glaw wrote:
> > On Mon, 2006-07-31 20:11:20 +0200, Matthias Andree <matthias.andree@gmx=
=2Ede> wrote:
> > > Jan-Benedict Glaw schrieb am 2006-07-31:
[Crippled DMA writes]
> > > Massive hardware problems don't count. ext2/ext3 doesn't look much be=
tter in
> > > such cases. I had a machine with RAM gone bad (no ECC - I wonder what
> >=20
> > They do! Very much, actually. These happen In Real Life, so I have to
>=20
> I think what he meant was that it is unfair to blame reiser3 for data
> loss in a massive failure situation as a case example by itself.  What

Crippling a few KB of metadata in the ext{2,3} case probably wouldn't
fobar the filesystem...

> failure robustness counts... "  This of course assumes you actually had
> the *exact* same problem with hardware under ext3, pretty much in every
> detail.  Of course, so many subtleties interact in massive ways with

The point is that it's quite hard to really fuck up ext{2,3} with only
some KB being written while it seems (due to the
fragile^Wsophisticated on-disk data structures) that it's just easy to
kill a reiser3 filesystem.

MfG, JBG

--=20
       Jan-Benedict Glaw       jbglaw@lug-owl.de                +49-172-760=
8481
   Signature of:                            Zensur im Internet? Nein danke!
   the second  :

--r3KnbM2MoJFBL7Dl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEzln+Hb1edYOZ4bsRAuvGAJ91Dr8JUemgL/p7VLScPQQGgfZsFwCeIQY9
p2hMLDRQ9eudbNCpNjwKsU4=
=JHrz
-----END PGP SIGNATURE-----

--r3KnbM2MoJFBL7Dl--
