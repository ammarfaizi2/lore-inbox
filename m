Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVC3TYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVC3TYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVC3TWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:22:22 -0500
Received: from ctb-mesg2.saix.net ([196.25.240.74]:65254 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S262418AbVC3TTL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:19:11 -0500
Subject: Re: How's the nforce4 support in Linux?
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050330150023.GB6878@irc.pl>
References: <2a0fbc59050325145935a05521@mail.gmail.com>
	 <1111792462.23430.25.camel@mindpipe> <20050329185825.GB20973@irc.pl>
	 <1112128807.5141.14.camel@mindpipe>  <20050330150023.GB6878@irc.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gsBpJB1qdkxPmswohJ8K"
Date: Wed, 30 Mar 2005 21:19:29 +0200
Message-Id: <1112210369.25867.7.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gsBpJB1qdkxPmswohJ8K
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-03-30 at 17:00 +0200, Tomasz Torcz wrote:
> On Tue, Mar 29, 2005 at 03:40:07PM -0500, Lee Revell wrote:
> > On Tue, 2005-03-29 at 20:58 +0200, Tomasz Torcz wrote:
> > > On Fri, Mar 25, 2005 at 06:14:22PM -0500, Lee Revell wrote:
> > > > On Fri, 2005-03-25 at 23:59 +0100, Julien Wajsberg wrote:
> > > > > - audio works too. The only problem is that two applications can'=
t
> > > > > open /dev/dsp in the same time.
> > > >=20
> > > > Not a problem.  ALSA does software mixing for chipsets that can't d=
o it
> > > > in hardware.  Google for dmix.
> > > >=20
> > > > However this doesn't (and can't be made to) work with the in-kernel=
 OSS
> > > > emulation (it works fine with the alsa-lib/libaoss emulation).  So =
you
> > >=20
> > >  quake3 still segfaults when run through "aoss". And can't be fixed, =
as
> > > it's closed source still.
> > >=20
> > I guess that's Quake3's problem...
>=20
>  It an glaring example, dmix is unsufficient in one third of my sound
> uses (other two beeing movie and music playback)
>  But you advertise dmix like it was silver bullet.
>=20

Or goes limbo randomly and no mailing to lists seems to result in a
reply (from the alsa peeps at least) ...


--=20
Martin Schlemmer


--=-gsBpJB1qdkxPmswohJ8K
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCSvvBqburzKaJYLYRAhoIAJ0S9JPFwrdj4TaBGxgeZ896xSKWLwCcCdmi
cSExEhGYwR69sTXG0W1lrB8=
=rxhx
-----END PGP SIGNATURE-----

--=-gsBpJB1qdkxPmswohJ8K--

