Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUFIMvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUFIMvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUFIMvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:51:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48085 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263850AbUFIMvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:51:11 -0400
Subject: Re: [STACK] >4k call path in hp/compaq fibre channel driver
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: chase.maupin@hp.com, iss_storagedev@hp.com, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040609124302.GI21168@wohnheim.fh-wedel.de>
References: <20040609124302.GI21168@wohnheim.fh-wedel.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4JH9Csq66ucciLfBOeGD"
Organization: Red Hat UK
Message-Id: <1086785454.2810.13.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Jun 2004 14:50:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4JH9Csq66ucciLfBOeGD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-06-09 at 14:43, J=C3=B6rn Engel wrote:
> Chase, I guess this code won't live long with 4k stacks.  Can you
> please fix CpqTsProcessIMQEntry() and PeekIMQEntry()?
>=20
> Linus, Andrew, how about marking CONFIG_SCSI_CPQFCTS as broken for the
> time being?

isn't it already? I thought it never got adjusted to the 2.6 scsi layer
already (or the 2.4 one for that matter)

--=-4JH9Csq66ucciLfBOeGD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAxweuxULwo51rQBIRAhQvAJ9bMj6ttd+sflUsKjKd9BK7ajIhHACdEQah
QAQPmrTb5A/Yp41LBH/GVYQ=
=TKfq
-----END PGP SIGNATURE-----

--=-4JH9Csq66ucciLfBOeGD--

