Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVL2HxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVL2HxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 02:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbVL2HxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 02:53:21 -0500
Received: from mail.gmx.net ([213.165.64.21]:37557 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932582AbVL2HxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 02:53:20 -0500
X-Authenticated: #5339386
Date: Thu, 29 Dec 2005 08:50:54 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: oops in kernel 2.6.15-rc6
Message-ID: <20051229075054.GC9777@sidney>
References: <20051228135021.GA9777@sidney> <43B2A122.7030203@thinrope.net> <20051228145502.GB9777@sidney> <84144f020512280715y61221ed0g381453cfd3c11c22@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <84144f020512280715y61221ed0g381453cfd3c11c22@mail.gmail.com>
User-Agent: Mutt/1.5.11
From: Mathias Klein <ma_klein@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 28, 2005 at 05:15:54PM +0200, Pekka Enberg wrote:
> #1 is the first oops. See die() in arch/i386/kernel/traps.c. Anyway,
> try enabling CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC to see if
> they pick up anything.

I'll give it a try and come back if it occurs again...

Thanks
Mathias


--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDs5VdPtJqRGqEpd8RAro+AKCJAgBb0ZIbXeNEgCwIGWKY+v6k6wCfYDAX
OrTPukg39fdqKNFE4Y1vKXA=
=uaBw
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
