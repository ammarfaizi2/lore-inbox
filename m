Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVFMRcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFMRcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 13:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVFMRcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 13:32:41 -0400
Received: from lug-owl.de ([195.71.106.12]:2451 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261152AbVFMRci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 13:32:38 -0400
Date: Mon, 13 Jun 2005 19:32:37 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Pausing a task
Message-ID: <20050613173236.GP3008@lug-owl.de>
Mail-Followup-To: Vadim Lobanov <vlobanov@speakeasy.net>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0506131142120.17826@chaos.analogic.com> <20050613160449.GJ3008@lug-owl.de> <Pine.LNX.4.58.0506130927040.12298@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJ8inJ6ig7iY3YX9"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506130927040.12298@shell2.speakeasy.net>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rJ8inJ6ig7iY3YX9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-06-13 09:27:41 -0700, Vadim Lobanov <vlobanov@speakeasy.net> w=
rote:
> On Mon, 13 Jun 2005, Jan-Benedict Glaw wrote:
> > On Mon, 2005-06-13 11:50:34 -0400, Richard B. Johnson <linux-os@analogi=
c.com> wrote:
> > > Let's say that "Hacker Jack" just got fired because
> > > he was disrupting a project. One needs to find any of
> > > his processes where he might be deleting a project
> > > tree. Pausing, rather than killing the tasks would
> > > allow evidence to be gathered. Basically, I need
> > > to set the task(s) priorities to something that
> > > will take them out of the run-queue altogether.
> >
> > ~# pkill -SIGSTOP -U richard
> >
> > < examine the situation, attach gdb/strace/ltrace/whatever >
> >
> > If you just want to let'em continue:
> >
> > ~# pkill -SIGCONG -U richard
>=20
> I think that's supposed to be "-SIGCONT" instead. :-)

Of course. You passed the test :->

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--rJ8inJ6ig7iY3YX9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCrcM0Hb1edYOZ4bsRAkEDAJ95YrQtxQLlnqI/Eadd8F0oFe3r9wCfa32Q
Gb2kSC2ks8KRE1OXOr2YlAc=
=6vD9
-----END PGP SIGNATURE-----

--rJ8inJ6ig7iY3YX9--
