Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264740AbTIJILh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264741AbTIJILh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:11:37 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:53486 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264740AbTIJIKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:10:24 -0400
Subject: Re: softraid + serverraid locking FS
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: elmer@linking.ee
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2739.195.80.106.123.1063183974.squirrel@mail.linking.ee>
References: <2739.195.80.106.123.1063183974.squirrel@mail.linking.ee>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FaNAC3rJm8sG09A/0/Xa"
Organization: Red Hat, Inc.
Message-Id: <1063181415.5021.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 10 Sep 2003 10:10:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FaNAC3rJm8sG09A/0/Xa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-09-10 at 10:52, elmer@linking.ee wrote:
>  cp -dpR lotsfiles2GB /testcopy
>=20
>                     SMP x335   UP x335
> serverraid-serverraid  OK          OK
> softraid-softraid      OK          OK
> softraid-serverraid    OK          OK
> serverraid5E-softraid  SLEEPY
> serverraid1E-softraid                PROBLEM
>=20
> it is redhat AS 2.4.9-25 kernel, SMP kernel for both.

that kernel is very old and heavily patched; lkml is not the place to
report problems, your Red Hat support contact is...

--=-FaNAC3rJm8sG09A/0/Xa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/XtxnxULwo51rQBIRAvvTAJwOxXNi9AyMO3OE8uG8ID2xzn4drQCfaSZn
9ms7X6YapuZU3bH6eCk/H0g=
=GLM5
-----END PGP SIGNATURE-----

--=-FaNAC3rJm8sG09A/0/Xa--
