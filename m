Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbUCRAW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbUCRAW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:22:58 -0500
Received: from ns.suse.de ([195.135.220.2]:28824 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262225AbUCRAW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:22:56 -0500
Date: Thu, 18 Mar 2004 01:20:27 +0100
From: Kurt Garloff <garloff@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: dynamic sched timeslices
Message-ID: <20040318002027.GO20121@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
	hch@infradead.org, Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040315224201.GX4452@tpkurt.garloff.de> <200403170013.38140.kernel@kolivas.org> <20040316142957.GX4452@tpkurt.garloff.de> <200403170745.02538.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82U+nxpba3czjIX9"
Content-Disposition: inline
In-Reply-To: <200403170745.02538.kernel@kolivas.org>
X-Operating-System: Linux 2.6.4-1-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--82U+nxpba3czjIX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Con,

On Wed, Mar 17, 2004 at 07:45:02AM +1100, Con Kolivas wrote:
> > That's why I think we should offer the tunables.
>=20
> If your workload is so dedicated to just number crunching it isn't hard t=
o add=20
> a zero to maximum timeslice in kernel/sced.c.=20

Of course I can compile a custom kernel for myself and tune all sorts of
things. But this is not the way most Linux users want to use Linux any
more. Actually that's a long time ago.

Best regards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux: SUSE Labs (Head)        <garloff@suse.de>    [SUSE Nuernberg, DE]

--82U+nxpba3czjIX9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAWOtFxmLh6hyYd04RAi3IAJsEqi+K4tFgAxlYmPbx22SDm/EOMgCfYVdZ
RcLlDcGpm9ZJKyYhvzTgujM=
=lP3y
-----END PGP SIGNATURE-----

--82U+nxpba3czjIX9--
