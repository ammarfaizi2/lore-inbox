Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbULCC7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbULCC7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 21:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbULCC7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 21:59:35 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.34]:37252 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261896AbULCC7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 21:59:34 -0500
Date: Fri, 3 Dec 2004 04:59:32 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: vlobanov <vlobanov@speakeasy.net>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, kkojima@rr.iij4u.or.jp
Subject: Re: EXPORT_SYMBOL_NOVERS question
Message-ID: <20041203025932.GJ867@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	vlobanov <vlobanov@speakeasy.net>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, kkojima@rr.iij4u.or.jp
References: <Pine.LNX.4.58.0411030007220.22814@shell2.speakeasy.net> <1101681740.25347.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <1101681740.25347.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 29, 2004 at 09:42:20AM +1100, Rusty Russell wrote:
> Vadim Lobanov points out that EXPORT_SYMBOL_NOVERS is no longer used;
> in fact, SH still uses it, but once we fix that, the kernel is clean.
> Remove it.
>=20
Looks good to me..

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBr9aU1K+teJFxZ9wRAiOXAJ94ivBdBWIvxl7p0PGdWqDHz5q8+gCggUpc
Os2GUsd2biYDLpTKMqDOZEA=
=duw1
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
