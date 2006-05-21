Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWEUIC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWEUIC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 04:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWEUIC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 04:02:26 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:15520 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751500AbWEUICZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 04:02:25 -0400
Date: Sun, 21 May 2006 10:02:12 +0200
From: Harald Welte <laforge@netfilter.org>
To: Nix <nix@esperi.org.uk>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: Linux 2.6.16.17
Message-ID: <20060521080212.GB5941@sunbeam.de.gnumonks.org>
References: <20060520230912.GJ23243@moss.sous-sol.org> <87fyj4fc7h.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <87fyj4fc7h.fsf@hades.wkstn.nix>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 21, 2006 at 01:33:54AM +0100, Nix wrote:
> On 21 May 2006, Chris Wright announced:
> > Harald Welte:
> >       Fix udev device creation
>=20
> As an aside, patches Cc:ed to stable that concern only a few specific
> drivers should probably mention the driver in the short changelog;
> e.g. this is specific to cm4000_cs.

yes, I very much second that.  To the best of my knowledge, I didn't
submit the patch to stable@ myself, but somebody else picked it up.  I
wasn't really sure whether it really fits the stable@ policy,

Anyway, my original posting contained the driver name in the subject
line.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEcB6EXaXGVTD0i/8RAjabAJ94HwvkLOfWUmigTexc862Wv0OVtwCgnJ4s
CujtySRXyDeANnY2ZsBqANw=
=rBv2
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
