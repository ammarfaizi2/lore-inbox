Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbTLaT27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 14:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbTLaT23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 14:28:29 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:14276 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265246AbTLaT2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 14:28:01 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Wed, 31 Dec 2003 14:27:57 -0500
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: alsa, esd, mpg123
Message-ID: <20031231192757.GB16909@butterfly.hjsoft.com>
References: <20031230155358.GB23963@butterfly.hjsoft.com> <Pine.LNX.4.58.0312301724470.3189@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312301724470.3189@pnote.perex-int.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2003 at 05:25:38PM +0100, Jaroslav Kysela wrote:
> On Tue, 30 Dec 2003, John M Flinchbaugh wrote:
> > on my debian (unstable) laptop newly running 2.6.0, i've noticed
> > an irritating tendency for music to not pause, but instead to
> > try to go too fast, skipping small parts of the song (fractions
> > of a second).  this results in music with regular beats sounding
> > erratic.
>=20
> Could you try this patch?
> ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-12-30.patch.gz

this patch built and the modules install just fine, but when i
try to play music, i just hear garbage beeps and blips.  that's
with or without esd.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8yM9CGPRljI8080RAr33AJ9ZhMmLWnBU0n1aih6BAu8LqfrDswCgiAVG
B9VDiVC6kv5ulFZWsyUUtag=
=ra0i
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
