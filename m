Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbTLPWzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 17:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTLPWzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 17:55:13 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:20362 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264239AbTLPWzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 17:55:04 -0500
Subject: Re: dmesg problem in 2.5.73
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: covici@ccs.covici.com,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20031216120547.0d3b77e2.rddunlap@osdl.org>
References: <m3he64c7qo.fsf@ccs.covici.com>
	 <1057228803.5499.243.camel@workshop.saharacpt.lan>
	 <20031216120547.0d3b77e2.rddunlap@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0jbSDMPa1aetDzYez7Mf"
Message-Id: <1071615424.5067.9.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 00:57:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0jbSDMPa1aetDzYez7Mf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-16 at 22:05, Randy.Dunlap wrote:
> On 03 Jul 2003 12:40:04 +0200 Martin Schlemmer <azarah@gentoo.org> wrote:
>=20
> | On Thu, 2003-07-03 at 10:52, John Covici wrote:
> | > Hi.  I have a weird problem -- maybe its iptables, but I am using the
> | > log target and they print at legvel 4, but I only want level 3 or
> | > less to print on the console, so I did 'dmesg -n 3' but I am still
> | > getting the iptables messages.
> | >=20
> | > I thought I could do this all with syslog.conf, but that has never
> | > worked.
> | >=20
> |=20
> | Changing DEFAULT_CONSOLE_LOGLEVEL (?) has been broken since
> | 2.5.70 or 2.5.71.  I checked kernel/printk.c, etc, but could
> | not see anything that was causing this.
>=20
> Hi,
>=20
> Is this still broken?  How do you test it?
>=20

Nop, was fixed some time back (don't ask when, as I cannot
remember).


Thanks,

--=20
Martin Schlemmer

--=-0jbSDMPa1aetDzYez7Mf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/343AqburzKaJYLYRAiq7AJ4llDMq9VnBay7mEpTb9EUlzubDUQCfRsg8
I5u7VBYcaLEv/TjxtIMS59M=
=Pmuq
-----END PGP SIGNATURE-----

--=-0jbSDMPa1aetDzYez7Mf--

