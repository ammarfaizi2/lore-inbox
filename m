Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTJWJ0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 05:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTJWJ0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 05:26:44 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:11137 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261705AbTJWJ0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 05:26:42 -0400
Date: Thu, 23 Oct 2003 11:26:41 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Message-ID: <20031023092641.GO20846@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0310222102160.25868-100000@chimarrao.boston.redhat.com> <000801c39903$034d3910$0201a8c0@joe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wBPuIvTBT75rft3J"
Content-Disposition: inline
In-Reply-To: <000801c39903$034d3910$0201a8c0@joe>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wBPuIvTBT75rft3J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-10-22 20:14:30 -0500, Joseph D. Wagner <theman@josephdwagner.i=
nfo>
wrote in message <000801c39903$034d3910$0201a8c0@joe>:
> > > Version 2.6 is still in beta.  Besides, this should have been done ye=
ars
> > > ago before 2.6 existed.
> >=20
> > So why haven't you done it?
>=20
> Um... because I don't have cvs WRITE access.

Nearly onbody has. However, you can download the latest kernel source
tarball, do your hacks and send us a patch to LKML. Then, you'll
possibly get some comments (better change this to do that, some
potential to do things better, ...). Send it again, until it's quite
good. Then, send it to Linus (or to the guy that's maintaining the part
you've changed) and LKML until it gets accepted.

That's the way it works.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--wBPuIvTBT75rft3J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/l57RHb1edYOZ4bsRArl0AJ0XBjZBbSKYv2tLpeUMBbOSfoD3xwCggwbi
7Xao10UYIV/8yFpt6vDgNec=
=8teO
-----END PGP SIGNATURE-----

--wBPuIvTBT75rft3J--
