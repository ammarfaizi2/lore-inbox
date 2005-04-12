Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVDLNMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVDLNMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVDLNMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:12:05 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:40589 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S262456AbVDLNJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 09:09:36 -0400
Subject: Re: Re: [ANNOUNCE] git-pasky-0.3
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Petr Baudis <pasky@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
In-Reply-To: <20050412130250.GG22614@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	 <20050409200709.GC3451@pasky.ji.cz>
	 <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	 <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz>
	 <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz>
	 <1113310045.23299.15.camel@nosferatu.lan>
	 <20050412130250.GG22614@pasky.ji.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-waE2iEYBBJz5i8lYBiwz"
Date: Tue, 12 Apr 2005 15:13:15 +0200
Message-Id: <1113311595.23299.17.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-waE2iEYBBJz5i8lYBiwz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-12 at 15:02 +0200, Petr Baudis wrote:
> Dear diary, on Tue, Apr 12, 2005 at 02:47:25PM CEST, I got a letter
> where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > On Mon, 2005-04-11 at 15:57 +0200, Petr Baudis wrote:
> > >   Hello,
> > >=20
> > >   here goes git-pasky-0.3, my set of patches and scripts upon
> > > Linus' git, aimed at human usability and to an extent a SCM-like usag=
e.
> > >=20
> >=20
> > Its pretty dependant on where VERSION is located.  This patch fixes
> > that. (PS, I left the output of 'git diff' as is to ask about the
> > following stuff after the proper diff ...)
>=20
> Thanks, applied. I don't understand your PS, though. :-)
>=20

Heh, yeah I do that sometimes.  Basically should 'git diff' output
anything (besides maybe not added files like cvs ... sorry, do not know
after what you fashion it) like it does now?

--=20
Martin Schlemmer


--=-waE2iEYBBJz5i8lYBiwz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCW8lrqburzKaJYLYRAr65AJ9wDZZZDrIYFNnJkgCKoLlEUpiVbQCdHY4n
fNWJCXCMZEO2XcnDBxBj5BU=
=IvJ5
-----END PGP SIGNATURE-----

--=-waE2iEYBBJz5i8lYBiwz--

