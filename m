Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265118AbUELQU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUELQU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 12:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUELQU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 12:20:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7149 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265118AbUELQU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 12:20:28 -0400
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1040512115750.23213A-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1040512115750.23213A-100000@gatekeeper.tmr.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/77voU8SX4pn3etKT7GN"
Organization: Red Hat UK
Message-Id: <1084378819.10949.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 12 May 2004 18:20:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/77voU8SX4pn3etKT7GN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > "4KSTACKS" already is present in the module version string.
> >=20
> > And Fedora is shipping now with 4k stacks, so presumably any disasters
> > are relatively uncommon...
>=20
> Fedora and kernel.org have a lot of unshared bugs and features,
> unfortunately. I take that information as an encouraging proof of concept=
,
> not a waranty that the kernel.org code will behave in a similar way.

Hey! That's slander of title! :-)
Seriously the difference between the Fedora Core 2 kernel and the
matching kernel.org kernel aren't THAT big. The 4g/4g split patch being
the biggest delta.


--=-/77voU8SX4pn3etKT7GN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAok7CxULwo51rQBIRAl+bAKCOVn0OhXv6N+HatZ43os69HFx+YACgiI6a
LKcwRKUIdJBPVbEGBlmsTg8=
=V1tm
-----END PGP SIGNATURE-----

--=-/77voU8SX4pn3etKT7GN--

