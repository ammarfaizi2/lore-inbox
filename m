Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUHTML5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUHTML5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUHTML5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:11:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18650 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266687AbUHTMLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:11:55 -0400
Subject: Re: 2.6.8.1-mm2 breaks vmware
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: vherva@viasys.com
Cc: petr@vandrovec.name, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040820104230.GH23741@viasys.com>
References: <20040820104230.GH23741@viasys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8xDJ4AkX3o8fVyMKqYf8"
Organization: Red Hat UK
Message-Id: <1093003898.2792.19.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 Aug 2004 14:11:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8xDJ4AkX3o8fVyMKqYf8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> So I backed out these patches from 2.6.8.1-mm2:
>=20
> 	flexible-mmap-2.6.7-mm3-A8.patch
> 	flex-mmap-for-ppc64.patch
> 	flex-mmap-for-s390x.patch
> 	sysctl-tunable-for-flexmmap.patch
unlikely candidates; these are in the fedora kernel too and no problems
reported with vmware like this...=20
(and we do get reports when vmware breaks ;)

--=-8xDJ4AkX3o8fVyMKqYf8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD4DBQBBJep6xULwo51rQBIRAmUNAKCM4kOOLDVbTVZtgZQwTUdZ3g3R+QCYy5gB
M46MlooLi4gj2z07b7EeVA==
=HhiA
-----END PGP SIGNATURE-----

--=-8xDJ4AkX3o8fVyMKqYf8--

