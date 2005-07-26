Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVGZWwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVGZWwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 18:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVGZWwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:52:08 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:43993 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S262312AbVGZWtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:49:45 -0400
Date: Wed, 27 Jul 2005 00:49:32 +0200
From: Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: mkrufky@m1k.net, linux-kernel@vger.kernel.org
Subject: Re: MM kernels - how to keep on the bleeding edge?
Message-Id: <20050727004932.1b25fc5d.astralstorm@gorzow.mm.pl>
In-Reply-To: <20050726144149.0dc7b008.akpm@osdl.org>
References: <20050726185834.76570153.astralstorm@gorzow.mm.pl>
	<42E692E4.4070105@m1k.net>
	<20050726221506.416e6e76.astralstorm@gorzow.mm.pl>
	<42E69C5B.80109@m1k.net>
	<20050726144149.0dc7b008.akpm@osdl.org>
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__27_Jul_2005_00_49_32_+0200_CJEzyioBixqXKtw_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__27_Jul_2005_00_49_32_+0200_CJEzyioBixqXKtw_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Jul 2005 14:41:49 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Michael Krufky <mkrufky@m1k.net> wrote:
> >
> > [ tracking mm stuff ]
> >
>=20
> Sigh, sorry.  It's hard.  -mm is always in flux.  I no longer send out the
> `patch was dropped' message because it disturbs people.=20

There were too many?=20
Or you were receiving a lot of mail from particular developers with
requests of explanation? :)

> The mm-commits
> list does not resend a patch when it is changed (other patches folded into
> it, rejects fixed, changelog updated, rediffed, etc). =20

This isn't so much a problem as the previous point. When there are rejects,
it's easy (most of the time) to fix them by hand anyway as I pull the tree.

> Sometimes I'll comment out a patch but not fully drop it. =20

Now I can see that, I can diff the series.=20
But if the change was large, the diff isn't very instructive.

> I pull all the git trees at
> least twice a day and that's not reflected on the mm-commits list either.
>=20

That's not a problem, I can pull them too. They're public.

> You can always tell when a -mm release is coming by watching the shower of
> stupid compile fixes emerging :(

I do notice that using the RSS already, :) And the usual shower isn't as
frequent and large nowadays as before.

>=20
> I spose I could emit a broken-out.tar.gz file occasionally (it'd be up to=
 5
> times a day), but there's no guarantee that it'll compile, let alone run.=
=20
> I could also send a notification to mm-commits when I do so.  Would that
> help?
>=20

Really, it would. Especially if it contained an up-to-date series file.
I'd be very grateful. (And would test and fix it up some more.)

--=20
AstralStorm

GPG Key ID =3D 0xD1F10BA2
GPG Key fingerprint =3D 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2
Please encrypt if you can.

--Signature=_Wed__27_Jul_2005_00_49_32_+0200_CJEzyioBixqXKtw_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQFC5r4DlUMEU9HxC6IRAvqQAJ0ZMuRMpF+d8sgqua46uj5RyF2GhACePjTf
g5AF2qfno2crUrppU9u1654=
=1von
-----END PGP SIGNATURE-----

--Signature=_Wed__27_Jul_2005_00_49_32_+0200_CJEzyioBixqXKtw_--
