Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264188AbTKSXLZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 18:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTKSXLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 18:11:25 -0500
Received: from wblv-224-88.telkomadsl.co.za ([165.165.224.88]:42757 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264188AbTKSXLX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 18:11:23 -0500
Subject: Re: [2.6 patch] document that udev isn't yet ready (fwd)
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20031119221456.GB22090@kroah.com>
References: <20031119213237.GA16828@fs.tum.de>
	 <20031119221456.GB22090@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JItz/aKn+e6LHH/JjhbI"
Message-Id: <1069283566.5032.21.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 20 Nov 2003 01:12:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JItz/aKn+e6LHH/JjhbI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-20 at 00:14, Greg KH wrote:
> On Wed, Nov 19, 2003 at 10:32:38PM +0100, Adrian Bunk wrote:
> > The trivial documentation patch forwarded below still applies (with a=20
> > few lines offset) against 2.6.0-test9-mm4.
>=20
> Hm, with the 006 release, what do you find lacking in udev?
>=20

I am guessing its more driver support, etc.  Input devices for
instance do not seem to have any sysfs support yet, and full
initramfs support with udev in there, and udev.permissions setup
to get general permissions, etc right, might make it more advertisable
for the masses (no need to maintain /dev or the initial costs for
users not so interested in the workings of things).

Lets just say from what I have seen from users talking/asking, the
initial setup and seeming 'lack of functionality' is the biggest
blocker.


Cheers,

--=20
Martin Schlemmer

--=-JItz/aKn+e6LHH/JjhbI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/u/juqburzKaJYLYRAhrwAKCdlP5JNM+ii/1I7TG5Er/o5Z8DcACfU9xY
DSb2kVqcVpSZQ0apiINemIM=
=Y8TO
-----END PGP SIGNATURE-----

--=-JItz/aKn+e6LHH/JjhbI--

