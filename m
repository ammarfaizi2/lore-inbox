Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTL2Jt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 04:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTL2Jt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 04:49:59 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:385 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263435AbTL2Jty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 04:49:54 -0500
Subject: Re: ataraid in 2.6.?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Nicklas Bondesson <nicke@nicke.nu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <S262196AbTL2AJ1/20031229000927Z+17179@vger.kernel.org>
References: <S262196AbTL2AJ1/20031229000927Z+17179@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aAXyPfELUAAmeMPhfzX1"
Organization: Red Hat, Inc.
Message-Id: <1072691350.5223.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Dec 2003 10:49:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aAXyPfELUAAmeMPhfzX1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-29 at 01:09, Nicklas Bondesson wrote:
> Hi!
>=20
> Is the ataraid framework planned to be ported to 2.6.x? If so, when could
> one expect it?

the plan is to have a userspace device mapper app take it's place.
As for the timeframe; I'm looking at it but the userspace device mapper
code is still a bit of a mystory to me right now.

--=-aAXyPfELUAAmeMPhfzX1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7/iWxULwo51rQBIRAldZAJ9W80erwyeBxYrcicrbeAUNfjJ8LgCgkh7V
qwyaxjUBHXklE+2HkFb1EVk=
=Ly6g
-----END PGP SIGNATURE-----

--=-aAXyPfELUAAmeMPhfzX1--
