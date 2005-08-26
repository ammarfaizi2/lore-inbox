Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVHZIsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVHZIsL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 04:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVHZIsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 04:48:10 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:49869 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932305AbVHZIsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 04:48:09 -0400
Date: Fri, 26 Aug 2005 10:35:27 +0200
From: Harald Welte <laforge@netfilter.org>
To: Sven Schuster <schuster.sven@gmx.de>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
Subject: Re: oops in 2.6.13-rc6-git12 in tcp/netfilter routines
Message-ID: <20050826083527.GD4226@rama.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Sven Schuster <schuster.sven@gmx.de>,
	Alessandro Suardi <alessandro.suardi@gmail.com>, netdev@oss.sgi.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	netfilter-devel@lists.netfilter.org
References: <5a4c581d05082506395fa984ae@mail.gmail.com> <20050825165550.GC4442@rama.de.gnumonks.org> <20050825210200.GA10374@zion.homelinux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5WqUoFLvi1M7tJE"
Content-Disposition: inline
In-Reply-To: <20050825210200.GA10374@zion.homelinux.com>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W5WqUoFLvi1M7tJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2005 at 11:02:01PM +0200, Sven Schuster wrote:
>=20
> Hi Harald,
>=20
> On Thu, Aug 25, 2005 at 06:55:50PM +0200, Harald Welte told us:
> > Is it true that PeerGuardian is a proprietary application?  I'm not
> > going to debug this problem using a proprietary ip_queue program, sorry.
>=20
> sorry to jump in here, but I took a quick look at PeerGuardian,
> according to
> http://methlabs.org/wiki/license_information
> it's open source.  The source code is available at
> http://methlabs.org/projects/peerguardian-linuxosx/

ok, thanks. Sorry for the confusion, but the 'official' website is just
a blog that didn't really reveal all that much information.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--W5WqUoFLvi1M7tJE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDDtROXaXGVTD0i/8RAry9AJ4gjMslIcm5T+nTvhKXHWHS5bdCVACgswYA
EUq2k+lWbO+nrpQO8dzOleQ=
=xE+q
-----END PGP SIGNATURE-----

--W5WqUoFLvi1M7tJE--
