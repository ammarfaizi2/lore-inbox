Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030574AbVJ1TQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030574AbVJ1TQc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbVJ1TQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:16:32 -0400
Received: from lug-owl.de ([195.71.106.12]:49381 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1030574AbVJ1TQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:16:31 -0400
Date: Fri, 28 Oct 2005 21:16:29 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.14
Message-ID: <20051028191629.GO27184@lug-owl.de>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20051028062921.GA6397@kroah.com> <20051028174812.GA15637@kroah.com> <20051028185530.GN27184@lug-owl.de> <20051028191107.GB16822@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOh8F6DNH/RZBSFD"
Content-Disposition: inline
In-Reply-To: <20051028191107.GB16822@kroah.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hOh8F6DNH/RZBSFD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-10-28 12:11:07 -0700, Greg KH <greg@kroah.com> wrote:
> On Fri, Oct 28, 2005 at 08:55:30PM +0200, Jan-Benedict Glaw wrote:
> > On Fri, 2005-10-28 10:48:12 -0700, Greg KH <gregkh@suse.de> wrote:
> > >  drivers/input/keyboard/lkkbd.c                 |  126 ++---
> >=20
> > Not ACKed.  This patch contains a not-fixed (though reported) wrong
> > printk format in lkkbd_interrupt() "case LK_METRONOME:" Though I
> > haven't tested it yet, it's ACKed by me after this is fixed.
>=20
> That can be a one-line add on patch once it is created.  I can easily
> send that later.

Jap, that's okay. But somebody needs to do that:)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--hOh8F6DNH/RZBSFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDYnkNHb1edYOZ4bsRAqdbAJ9UKyna9RsxfQcjrj3w1zGwZfD1IgCdHlO/
JWvYY/DkRZi3lIQYcaj8lYM=
=gGAx
-----END PGP SIGNATURE-----

--hOh8F6DNH/RZBSFD--
