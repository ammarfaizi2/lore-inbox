Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbTANQ2Y>; Tue, 14 Jan 2003 11:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbTANQ2Y>; Tue, 14 Jan 2003 11:28:24 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:2062 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S264797AbTANQ2X>; Tue, 14 Jan 2003 11:28:23 -0500
Subject: Re: Bugs and Releases Numbers
From: "Richard B. Tilley " "(Brad)" <rtilley@vt.edu>
To: jw schultz <jw@pegasys.ws>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030113225217.GC17075@pegasys.ws>
References: <1042469616.28005.36.camel@oubop4.bursar.vt.edu>
	<20030113150708.GI21826@fs.tum.de>
	<1042471046.28000.42.camel@oubop4.bursar.vt.edu> 
	<20030113225217.GC17075@pegasys.ws>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-GKi9SeyKQoyY7t6tV1sQ"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Jan 2003 11:37:11 -0500
Message-Id: <1042562235.420.37.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GKi9SeyKQoyY7t6tV1sQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On Mon, 2003-01-13 at 17:52, jw schultz wrote:

> No.  A new kernel need not be released right away.  Patches
> would be made available for affected recent releases.
> Anyone running self-built downloaded kernels is expected to
> be able to patch them when needed.  Distributions would
> apply the patch to their trees and make the new kernel
> (source and binaries) available through their usual security
> update channels.

It has been my experience that distro kernels come with everything and
then more of everything. Sure, they're mostly modular, but this approach
adds complexity that's unnecessary. So, I normally get kernel.org stable
kernel source and build a non-modular kernel specifically for my
hardware.=20

I was just trying to determine how security patches are handle by the
kernel developers, that's all. The idea that people should look to
distros for security is absurd to me, especially if the bug in question
affects the vanilla kernel.
=20
> It simply isn't necessary to rush a release (contrary to the
> principles of stable) just because there is a security hole.
> Patches are sufficient.  Besides, most sites run the
> distribution kernels anyway so they will get the fix through
> those channels.


--=-GKi9SeyKQoyY7t6tV1sQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+JDy3PJE6j+LlAWERAghWAKCIjgvtyiSNm1RyFdar9b7y1WiFEgCfUgyU
R3R+E0X8OmGLPYTnZ85CpLQ=
=QPt8
-----END PGP SIGNATURE-----

--=-GKi9SeyKQoyY7t6tV1sQ--

