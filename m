Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWERQ16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWERQ16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 12:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWERQ16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 12:27:58 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:57755 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751373AbWERQ15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 12:27:57 -0400
Date: Thu, 18 May 2006 18:27:54 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Andy Ross <andy@plausible.org>
Cc: Florent Thiery <Florent.Thiery@int-evry.fr>,
       openezx-devel@lists.gnumonks.org, linux-kernel@vger.kernel.org
Subject: Re: How should Touchscreen Input Drives behave (OpenEZX pcap_ts)
Message-ID: <20060518162754.GH17897@sunbeam.de.gnumonks.org>
References: <20060518070700.GT17897@sunbeam.de.gnumonks.org> <446C5780.7050608@int-evry.fr> <20060518143824.GC17897@sunbeam.de.gnumonks.org> <446C9E93.1030606@plausible.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bNLLTo5eXWXFd6av"
Content-Disposition: inline
In-Reply-To: <446C9E93.1030606@plausible.org>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bNLLTo5eXWXFd6av
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2006 at 09:19:31AM -0700, Andy Ross wrote:
> Harald Welte wrote:
> > No, this touchscreen actually has fairly reasonable pressure
> > reporting.  I know that this is unusual.  But I get reproducible
> > numbers when trying soft stylus press, hard stylus press.
>=20
> Really?  Maybe we have different hardware.  I just checked again, and
> all I can get out of my A780 is a boolean...

with what? with the original motorola kernel? which values are you
looking at?

I am talking about my new driver, running on 2.6.16.13-ezx5, not about
what Motorola ships in their 2.4.x based firmware.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
We all know Linux is great...it does infinite loops in 5 seconds. -- Linus

--bNLLTo5eXWXFd6av
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEbKCKXaXGVTD0i/8RAl6SAJ94RBSlXaAv2VmzNxc1+1P4oamROACgiIPH
BCW0njgL9JWyiUb4gA/czL8=
=RNHQ
-----END PGP SIGNATURE-----

--bNLLTo5eXWXFd6av--
