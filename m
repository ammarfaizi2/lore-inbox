Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUBINEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUBINEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:04:48 -0500
Received: from mhub-c5.tc.umn.edu ([160.94.128.35]:48607 "EHLO
	mhub-c5.tc.umn.edu") by vger.kernel.org with ESMTP id S265225AbUBINEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:04:46 -0500
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040209115852.GB877@schottelius.org>
References: <20040209115852.GB877@schottelius.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TqKUrlcYnm+slYq4ziSV"
Message-Id: <1076331883.542.7715.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 09 Feb 2004 07:04:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TqKUrlcYnm+slYq4ziSV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-02-09 at 05:58, Nico Schottelius wrote:
> Morning!
>=20
> What Linux supported filesystems support UTF-8 filenames?
>=20
> Looks like at least xfs and reiserfs are not able of handling them,
> as Apache with UTF-8 as default charset delievers wrong names, when
> accessing files with German umlauts.

I have no problem creating and accessing files with Chinese names
using ls, vi, cat, etc. in (u)xterm on my reiserfs /tmp partition.

Matt

--=-TqKUrlcYnm+slYq4ziSV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAJ4VqA9ZcCXfrOTMRAsquAJ0UuP4OHpF1+QHIaiJGtraM3KUJdACgtFQo
6N6GB0FwQRRKcFiHsfOZHDY=
=Bkkb
-----END PGP SIGNATURE-----

--=-TqKUrlcYnm+slYq4ziSV--

