Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276661AbRJGUUp>; Sun, 7 Oct 2001 16:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276669AbRJGUUf>; Sun, 7 Oct 2001 16:20:35 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:61570 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S276661AbRJGUUV>; Sun, 7 Oct 2001 16:20:21 -0400
Date: Sun, 7 Oct 2001 15:20:48 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: george anzinger <george@mvista.com>
Cc: J Sloan <jjs@pobox.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: low-latency patches]
Message-ID: <20011007152048.C7516@draal.physics.wisc.edu>
In-Reply-To: <3BBEAA2C.1005F7F4@pobox.com> <3BC099CD.9174A32@mvista.com> <20011007131417.A7516@draal.physics.wisc.edu> <3BC0B414.15A0AE83@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3BC0B414.15A0AE83@mvista.com>; from george@mvista.com on Sun, Oct 07, 2001 at 12:59:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

george anzinger [george@mvista.com] wrote:
> Bob McElrath wrote:
> >=20
> > george anzinger [george@mvista.com] wrote:
> > > The two patches are NOT mutually exclusive.  Both can be used and are=
 in
> > > some cases.
> > >
> > > MontaVista is actively working on porting the patch you refer to as
> > > Robert Love's patch to most of the other archs.  Which arch are you
> > > interested in?
> >=20
> > alpha.  ;)  I'd be happy to test early patches.
> >=20
> I am checking.  Meanwhile, do you know alpha asm?  The changes are
> relatively simple.

No, but I could probably figure it out (I know x86 asm, so might be able to
convert the routines).  I looked at it briefly and decided it would take me
more than an hour to add alpha asm, so didn't do it immediately.  ;)

If I hack something together (and it works), I'll send it to you.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvAuSAACgkQjwioWRGe9K2UpwCfRv1qTTgvwNKT7zwB0MjliWOq
uOcAnRyIt2h02r/opHXCXwHXeJhg+6cF
=+Ibq
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
