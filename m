Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263471AbTDDRrA (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263530AbTDDRor (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 12:44:47 -0500
Received: from adsl-67-121-155-183.dsl.pltn13.pacbell.net ([67.121.155.183]:11232
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S263900AbTDDRjK (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 12:39:10 -0500
Date: Fri, 4 Apr 2003 09:50:34 -0800
To: Andrey Panin <pazke@orbita1.ru>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] missing FB_VISUAL_PSEUDOCOLOR in fb_prepare_logo()
Message-ID: <20030404175034.GA819@triplehelix.org>
References: <20030404095837.GB964@pazke>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20030404095837.GB964@pazke>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2003 at 01:58:37PM +0400, Andrey Panin wrote:
> Hi,
>=20
> this patch (2.5.66) fixes mighty penguin logo not appearing
> on visual workstation framebuffer. The trouble is missing
> 'case FB_VISUAL_PSEUDOCOLOR:' in fb_prepare_logo() function.

This repairs the logo for me on i386 as well. Thanks.
If only the console cursor weren't so dodgy ... it would be=20
perfect now ;)

-Josh

--=20
New PGP public key: 0x27AFC3EE

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+jcXqT2bz5yevw+4RAp4PAKClgfAeT60JPbjD5oyAv4yl5BPXzACgheyL
bYW5yjnuJ+HcbDDuppPt9pg=
=HsSw
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
