Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUFKIDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUFKIDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 04:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUFKIDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 04:03:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53132 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261988AbUFKHFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 03:05:15 -0400
Subject: Re: ENOMEM in do_get_write_access, retrying
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Bikram Assal <bikram.assal@wku.edu>
Cc: Burton Windle <bwindle@fint.org>, linux-kernel@vger.kernel.org
In-Reply-To: <web-68590618@mailadmin.wku.edu>
References: <web-68590618@mailadmin.wku.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ikjiy/QJ19+mfRNKs3R3"
Organization: Red Hat UK
Message-Id: <1086937510.2731.14.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 11 Jun 2004 09:05:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ikjiy/QJ19+mfRNKs3R3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-11 at 00:07, Bikram Assal wrote:
> The kernel version installed on the server is 2.4.18-5
>=20
> Would that be a problem ?
No
>  Do I need to upgrade my kernel ?

Yes (well if it's a RHL kernel that is, but even if it's from another
vendor; 2.4.18 had quite a long list of security holes that got since
fixed so you'll want an upgrade)


--=-ikjiy/QJ19+mfRNKs3R3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAyVmmxULwo51rQBIRAgQPAJ9AETd8lh+XGvP5xcMklVtR/xd4YACgqzPX
i9K6IO7qWN7f31DYBcPs+fY=
=/tcc
-----END PGP SIGNATURE-----

--=-ikjiy/QJ19+mfRNKs3R3--

