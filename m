Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWGaRUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWGaRUG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWGaRUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:20:06 -0400
Received: from lug-owl.de ([195.71.106.12]:28587 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030273AbWGaRUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:20:04 -0400
Date: Mon, 31 Jul 2006 19:20:02 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Rudy Zijlstra <rudy@edsons.demon.nl>
Cc: Adrian Ulrich <reiser4@blinkenlights.ch>,
       Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060731172002.GM31121@lug-owl.de>
Mail-Followup-To: Rudy Zijlstra <rudy@edsons.demon.nl>,
	Adrian Ulrich <reiser4@blinkenlights.ch>,
	Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
	ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
	jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
References: <1153760245.5735.47.camel@ipso.snappymail.ca> <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl> <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org> <20060731175958.1626513b.reiser4@blinkenlights.ch> <20060731162224.GJ31121@lug-owl.de> <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rPgHZmYkQ+bUEpVC"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rPgHZmYkQ+bUEpVC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-31 18:44:33 +0200, Rudy Zijlstra <rudy@edsons.demon.nl> wro=
te:
> On Mon, 31 Jul 2006, Jan-Benedict Glaw wrote:
> > On Mon, 2006-07-31 17:59:58 +0200, Adrian Ulrich=20
> > <reiser4@blinkenlights.ch> wrote:
> > > A colleague of mine happened to create a ~300gb filesystem and started
> > > to migrate Mailboxes (Maildir-style format =3D many small files (1-3k=
b))
> > > to the new LUN. At about 70% the filesystem ran out of inodes; Not a
> >=20
> > So preparation work wasn't done.
>=20
> Of course you are right. Preparation work was not fully done. And using=
=20
> ext1 would also have been possible. I suspect you are still using ext1,=
=20
> cause with proper preparation it is perfectly usable.

Nope, I'm a quite happy ext3 user for quite divergent workloads.
Starting with storing loads of small files in a hugh number of
directories (mkfs -T news) over hugh numbers of files in few
directories (mkfs -O dir_index) to only a small number of really hugh
files (mkfs -T largefile4).

All that I still need to catch up with is 4TB sized files. But I guess
this is really an uncommon workload, but ISTR that somebody even works
on this.

MfG, JBG

--=20
       Jan-Benedict Glaw       jbglaw@lug-owl.de                +49-172-760=
8481
 Signature of:                       Don't believe in miracles: Rely on the=
m!
 the second  :

--rPgHZmYkQ+bUEpVC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEzjvCHb1edYOZ4bsRAh/CAJsH2mGOd2BsF6emuzMtt+D1Ub4GtgCfY7w6
EbL/cKZsOAC4Rw0SwXi845o=
=f1Q9
-----END PGP SIGNATURE-----

--rPgHZmYkQ+bUEpVC--
