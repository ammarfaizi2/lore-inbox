Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272404AbTHBJ4B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 05:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272457AbTHBJ4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 05:56:01 -0400
Received: from viriato1.servicios.retecal.es ([212.89.0.44]:33689 "EHLO
	viriato1.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S272404AbTHBJz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 05:55:59 -0400
Subject: Re: [2.6.0-test2-mm2] Badness in device_release at
	drivers/base/core.c:84
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <ramon.rey@hispalinux.es>
To: Greg KH <greg@kroah.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20030802025621.GA2651@kroah.com>
References: <1059785617.1873.5.camel@debian>
	 <20030802025621.GA2651@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jtOICpDKfPfgW7PlxKmI"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1059818154.1037.8.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 02 Aug 2003 11:55:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jtOICpDKfPfgW7PlxKmI
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

El s?, 02-08-2003 a las 04:56, Greg KH escribi=F3:
> On Sat, Aug 02, 2003 at 02:53:38AM +0200, Ram=F3n Rey Vicente???? wrote:
> > Hi.
> >=20
> > I obtain the included log messages on reboots
> >=20
> > Badness in device_release at drivers/base/core.c:84
> > Badness in kobject_cleanup at lib/kobject.c:402
>=20
> Please search the archives before posting this kind of stuff.
>=20
> These problems have been fixed and are in Linus's tree.

Ups, I'm sorry , I'll be more careful the next time :(.=20

Good job Greg!
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
------------------------------------------------------------
gpg public key ID 0xBEBD71D5 # http://pgp.escomposlinux.org/

--=-jtOICpDKfPfgW7PlxKmI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/K4qqRGk68b69cdURAnwOAJ0c/3lNqAQ5iscILG0eoiNMsOOAoACfZfJe
lGgY2sKqMN27r+l8RUsaFPo=
=8CwI
-----END PGP SIGNATURE-----

--=-jtOICpDKfPfgW7PlxKmI--

