Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUA3LOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbUA3LOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:14:39 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:38149 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S263088AbUA3LOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:14:37 -0500
Date: Fri, 30 Jan 2004 06:14:36 -0500
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm2
Message-ID: <20040130111435.GB2505@babylon.d2dc.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040130014108.09c964fd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <20040130014108.09c964fd.akpm@osdl.org>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2004 at 01:41:08AM -0800, Andrew Morton wrote:
>=20
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2=
=2E6.2-rc2-mm2/
>=20
>=20
> - I added a few late-arriving patches.  Usually this breaks things.
>=20
> - Added a few external development trees (USB, XFS).
>=20
> - PNP update

This patch contains:
--- linux-2.6.2-rc2/./include/linux/sched.h	2004-01-25 20:49:43.000000000 -=
0800
+++ 25/./include/linux/sched.h	2004-01-29 23:27:45.000000000 -0800
=2E..
--- linux-2.6.2-rc2/include/linux/sched.h	2004-01-25 20:49:43.000000000 -08=
00
+++ 25/include/linux/sched.h	2004-01-29 23:27:45.000000000 -0800

Both of which seem to be the exact same patch.

This obviously causes some problems when applying.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

This is commonly attributed to the lusers spending too much time talking
with their BOFH. They start thinking their name is "Moron" or "Dimwit"
because you keep calling them that.  -- Toni Lassila <toni@nukespam.org>
    in the Scary Devil Monastery about lusers forgetting their own names

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAGjybRFMAi+ZaeAERApnnAKCBL/y1e1lMAcjouF/KVClZvV00MwCdE2Oa
9zIGCT3m+8003pztPXVKOA8=
=P4KP
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
