Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbTKHUcK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 15:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbTKHUcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 15:32:10 -0500
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171]:57493 "EHLO
	caphernaum.rivenstone.net") by vger.kernel.org with ESMTP
	id S263927AbTKHUcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 15:32:07 -0500
Date: Sat, 8 Nov 2003 15:31:03 -0500
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mii broken for 3c59x ?
Message-ID: <20031108203103.GA9819@rivenstone.net>
Mail-Followup-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0311052142040.19211@dns.toxicfilms.tv> <3FAA4EF9.70704@pobox.com> <Pine.LNX.4.51.0311061606560.715@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0311061606560.715@dns.toxicfilms.tv>
User-Agent: Mutt/1.5.4i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2003 at 04:08:00PM +0100, Maciej Soltysiak wrote:
> > Most likely you need to recompile mii-tool, because it's using old ioct=
ls.
> It's from debian packages. I'll get the sources, compile, and see if it
> works.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D133648

1 year and 268 days old.

--=20
Joseph Fannin
jhf@rivenstone.net



--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/rVKGWv4KsgKfSVgRAqjiAJ0T6ByVZ80IDesCyjumcrbDEqitpwCfUSH1
ZY1HnChtUyL0pmQVpDNtmvA=
=S83I
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
