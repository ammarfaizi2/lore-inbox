Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268159AbUJJHhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268159AbUJJHhi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 03:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268162AbUJJHhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 03:37:38 -0400
Received: from cs181087074.pp.htv.fi ([82.181.87.74]:56812 "EHLO
	Unusual.Internal.Linux-SH.ORG") by vger.kernel.org with ESMTP
	id S268159AbUJJHhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 03:37:35 -0400
Date: Sun, 10 Oct 2004 10:37:32 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: Matt <matt@lpbproductions.com>
Cc: Jan Dittmer <jdittmer@ppp0.net>, Ed Schouten <ed@il.fontys.nl>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch 1/5] xbox: add 'CONFIG_X86_XBOX' to kernel configuration
Message-ID: <20041010073732.GA18628@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Matt <matt@lpbproductions.com>, Jan Dittmer <jdittmer@ppp0.net>,
	Ed Schouten <ed@il.fontys.nl>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <64778.217.121.83.210.1097351837.squirrel@217.121.83.210> <200410091315.10988.lkml@lpbproductions.com> <41684BC1.5000500@ppp0.net> <200410091347.57256.matt@lpbproductions.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <200410091347.57256.matt@lpbproductions.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 09, 2004 at 01:47:56PM -0700, Matt wrote:
> If it does go into mainline. What's to stop the inclusion of other gaming=
=20
> platforms into the kernel . Say for instance Playstation or Gamecube or s=
ome=20
> other variant.=20
>=20
PlayStation 1 won't make it due to the current state of mipsnommu.

On the other hand, Dreamcast support in the kernel as is is quite good.
It's actually one of the best supported platforms of the sh arch.

I'm not sure I get your point about keeping gaming platforms out of the
kernel, they're just another embedded platform, what's the issue?


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBaOa81K+teJFxZ9wRAsQ8AJ9taASckuoloMop3/T5ww6LWSNeaACfZAM/
VhwDT3tmf4RyJlOrV8IdI8U=
=fGQF
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
