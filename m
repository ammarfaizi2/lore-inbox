Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVKEQL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVKEQL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVKEQL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:11:29 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:36271 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932093AbVKEQL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:11:28 -0500
Date: Sat, 5 Nov 2005 18:11:24 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] sh: SuperHyway support for SH4-202.
Message-ID: <20051105161124.GA26333@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051102223118.GD27200@linux-sh.org> <20051104192840.395d1503.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20051104192840.395d1503.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 04, 2005 at 07:28:40PM -0800, Andrew Morton wrote:
> Paul Mundt <lethal@linux-sh.org> wrote:
> >
> > +int __init superhyway_scan_bus(struct superhyway_bus *bus)
>=20
> This appears to be unreferenced, and perhaps doesn't need global scope?

It's used in drivers/sh/superhyway/superhyway.c:superhyway_init().

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDbNms1K+teJFxZ9wRAqj8AJ9+iQS2N+u5EoOr12mEzbtoGG+HHwCaAynD
aLs+ZIiXVuxSl6uJIFb/ovE=
=fAzx
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
