Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTDYUSJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 16:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTDYUSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 16:18:09 -0400
Received: from [195.167.170.152] ([195.167.170.152]:55945 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S263871AbTDYUSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 16:18:07 -0400
Date: Fri, 25 Apr 2003 21:30:17 +0100
From: Athanasius <link@miggy.org>
To: Bill Davidsen <davidsen@tmr.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1
Message-ID: <20030425203017.GA16910@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>,
	Bill Davidsen <davidsen@tmr.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030423164015.GJ25981@miggy.org> <Pine.LNX.3.96.1030424174457.11734G-101000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1030424174457.11734G-101000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.28i
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2003 at 12:17:43PM -0400, Bill Davidsen wrote:
> On Wed, 23 Apr 2003, Athanasius wrote:
>=20
> >   Yup, that *seems* to have fixed it.  Booted up, updatedb run, compile
> > of a few things done, running X, even burned a CD, no sign of the
> > reported problem.
> >=20
> >   This could do with some easily accessible documentation someplace, but
> > I'm not sure *where* such should go.
>=20
> I dont think this is a fix, it's a work-around. It shouldn't be
> documnented, it should be made to work. That might mean having the kbuild
> prevent inappropriate use, of course.

  Agreed, I more meant it needs documenting so that those people that
hit it can apply the workaround and otherwise test the kernels.  I guess
for now those of us that know about it will just have to keep an eye out
for others reporting the problem then clue them in.

-Ath, now happily running 2.4.21-rc1, when he couldn't run anything past
2.4.21-pre4 before
--=20
- Athanasius =3D Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj6pmtkACgkQIr2uvLNOS8PB+ACfQZvUPowDkQfaQXzM06LCO+Ex
8woAniA02bIDkOM1a4djCa0K5Gm4KTmu
=lyY/
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
