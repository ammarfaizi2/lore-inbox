Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265236AbUFRPkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265236AbUFRPkE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUFRPgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:36:15 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:56277 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S265276AbUFRPdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:33:55 -0400
Date: Fri, 18 Jun 2004 17:33:50 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>,
       Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       4Front Technologies <dev@opensound.com>
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618153350.GB20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@redhat.com>, Jens Axboe <axboe@suse.de>,
	Andrew Morton <akpm@osdl.org>,
	4Front Technologies <dev@opensound.com>
References: <20040618082708.GD12881@suse.de> <Pine.LNX.4.44.0406181037180.8065-100000@chimarrao.boston.redhat.com> <20040618151315.GC1863@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LgQ6cFTvYTl1gsEY"
Content-Disposition: inline
In-Reply-To: <20040618151315.GC1863@holomorphy.com>
X-Operating-System: Linux mail 2.4.18
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LgQ6cFTvYTl1gsEY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-18 08:13:15 -0700, William Lee Irwin III <wli@holomorphy.co=
m>
wrote in message <20040618151315.GC1863@holomorphy.com>:
> On Fri, Jun 18, 2004 at 10:43:19AM -0400, Rik van Riel wrote:
> > Yes, this is a hint at certain embedded developers.  You
> > know who you are and chances are you also know what you would
> > like to develop if you no longer had to spend your time porting
> > the same old patches from one version of the product to the next.
>=20
> The shame of things is that the economic/effort problem appears to
> often be "solved" by never migrating to new kernel versions, or
> otherwise by amortizing the work involved with infrequent migrations.

Unfortunately, you're *very* right on this. Eg. read the linux-mips list
(at linux-mips.org). You'll see that this list is often hit by people
having problems. Normally, they hack on kernels like 2.4.16 or the like.
These are totally unrelated projects, people and companies. I can't find
words for that. They're missing a year of development and even feel sane
with it. That's what vendors gave them...

There's a lot of Linux beyond LKML, with a common problem: outdated
source trees, with a shitload of patches. Linus could need another
hacker or two working full-time on reviewing / importing those patches!
For what I guess, those should better be native Indian speakers...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--LgQ6cFTvYTl1gsEY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0wteHb1edYOZ4bsRAmQyAJ9GSDtZZ7DPPe+EMk+aI8XHUZ6ojQCeOrhd
mvd6p61h01zEJZ2UsdJJ2XI=
=NTfa
-----END PGP SIGNATURE-----

--LgQ6cFTvYTl1gsEY--
