Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWGaSnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWGaSnQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 14:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWGaSnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 14:43:16 -0400
Received: from lug-owl.de ([195.71.106.12]:37836 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030309AbWGaSnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 14:43:16 -0400
Date: Mon, 31 Jul 2006 20:43:14 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060731184314.GQ31121@lug-owl.de>
Mail-Followup-To: Rudy Zijlstra <rudy@edsons.demon.nl>,
	Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
	ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
	jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <1153760245.5735.47.camel@ipso.snappymail.ca> <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl> <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org> <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731162224.GJ31121@lug-owl.de> <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl> <20060731173239.GO31121@lug-owl.de> <20060731181120.GA9667@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LkYZvX65tyO4RZtj"
Content-Disposition: inline
In-Reply-To: <20060731181120.GA9667@merlin.emma.line.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LkYZvX65tyO4RZtj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-31 20:11:20 +0200, Matthias Andree <matthias.andree@gmx.de>=
 wrote:
> Jan-Benedict Glaw schrieb am 2006-07-31:
> >   * reiser3: A HDD containing a reiser3 filesystem was tried to be
> >     booted on a machine that fucked up DMA writes. Fortunately, it
> >     crashed really soon (right after going for read-write.)  After
> >     rebooting the HDD on a sane PeeCee, it refused to boot. Starting
> >     off some rescue system showed an _empty_ root filesystem.
>=20
> Massive hardware problems don't count. ext2/ext3 doesn't look much better=
 in
> such cases. I had a machine with RAM gone bad (no ECC - I wonder what

They do! Very much, actually. These happen In Real Life, so I have to
pay attention to them. Once you're in setups with > 10000 machines,
everything counts. At some certain point, you can even use HDD's
temperature sensors in old machines to diagnose dead fans.

Everything that eases recovery for whatever reason is something you
have to pay attention to. The simplicity of ext{2,3} is something I
really fail to find proper words for. As well as the really good fsck.
Once seen a SIGSEGV'ing fsck, you really don't want to go there.

MfG, JBG

--=20
       Jan-Benedict Glaw       jbglaw@lug-owl.de                +49-172-760=
8481
 Signature of:                       Eine Freie Meinung in einem Freien Kopf
 the second  :                     f=C3=BCr einen Freien Staat voll Freier =
B=C3=BCrger.

--LkYZvX65tyO4RZtj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEzk9CHb1edYOZ4bsRAmsiAJwMqr7hsRDF1pxvmPOhHiY+6HO51ACeId1T
3+MQfOpVL48J6jjeqK6I0m4=
=D7WL
-----END PGP SIGNATURE-----

--LkYZvX65tyO4RZtj--
