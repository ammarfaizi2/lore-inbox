Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268263AbUIPRXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268263AbUIPRXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268215AbUIPRUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:20:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49634 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268263AbUIPRQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:16:25 -0400
Subject: Re: 2.6.9-rc2-mm1
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200409161345.56131.norberto+linux-kernel@bensa.ath.cx>
References: <20040916024020.0c88586d.akpm@osdl.org>
	 <200409161345.56131.norberto+linux-kernel@bensa.ath.cx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Eh8OG53CY4tgyC5pyVl8"
Organization: Red Hat UK
Message-Id: <1095354962.2698.22.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Sep 2004 19:16:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Eh8OG53CY4tgyC5pyVl8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-16 at 18:45, Norberto Bensa wrote:
> Andrew Morton wrote:
> > +tune-vmalloc-size.patch
>=20
> This one of course breaks nvidia's binary driver; so nvidia users should =
do a=20
> "patch -Rp1" to revert it.

eh why how ?? what evil stuff is nvidia doing this time ?

--=-Eh8OG53CY4tgyC5pyVl8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBScpSxULwo51rQBIRAoKAAJwJmG5SvQ8x/U6RHuU0xLO2DkuizgCbB0N7
w3KHXtDIAKlASwaBqkE7Mqg=
=8rP4
-----END PGP SIGNATURE-----

--=-Eh8OG53CY4tgyC5pyVl8--

