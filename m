Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVCJKWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVCJKWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 05:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVCJKWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 05:22:22 -0500
Received: from dea.vocord.ru ([217.67.177.50]:39091 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262501AbVCJKWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 05:22:16 -0500
Subject: Re: [0/many] Acrypto - asynchronous crypto layer for linux kernel
	2.6
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Joshua Jackson <lkernel@vortech.net>
Cc: linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>,
       cryptoapi@lists.logix.cz
In-Reply-To: <200503080824.35464.lkernel@vortech.net>
References: <11102278521318@2ka.mipt.ru> <1110229998.13172.48.camel@ghanima>
	 <20050308004944.60fedb51@zanzibar.2ka.mipt.ru>
	 <200503080824.35464.lkernel@vortech.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-p/gzwMLDQkfL1tMLfaDV"
Organization: MIPT
Date: Thu, 10 Mar 2005 13:27:30 +0300
Message-Id: <1110450450.21110.39.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 10 Mar 2005 13:21:04 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p/gzwMLDQkfL1tMLfaDV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-08 at 08:24 -0500, Joshua Jackson wrote:
> On Monday 07 March 2005 4:49 pm, Evgeniy Polyakov wrote:
> >
> > Unfortunately acrypto patch is more than 200kb, so neither mail list
> > will accept it, so I've sent it in such form :)
> >
>=20
> As per the FAQ, very large patches are often best submitted as a URL. In =
case=20
> you don't have a place to host it, you are welcome to email me the comple=
te=20
> patch and I will post a URL link.

Patch on the web has quite small interest for the majority of the
people,
but probably it is better than 50+ e-mails...

The latest sources which can be compiled as external module=20
are available at=20
http://tservice.net.ru/~s0mbre/archive/acrypto/acrypto_latest.tar.gz

> I am very interested in your async changes and possibly porting some of t=
he=20
> Free/OpenBSD HW crypto drivers over to it.

That would be very good.
You can find HIFN, VIA, FCRYPT drivers created for acrypto at
http://tservice.net.ru/~s0mbre/archive/acrypto/drivers

P.S. Above site is currently down, it will be turned on asap.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-p/gzwMLDQkfL1tMLfaDV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCMCESIKTPhE+8wY0RAhpjAJ9r1hYu/jBmCIG7k7ONyLP1rBPucACfYAWH
xzzPXmY3Ir5k/xvF2U/LrZU=
=7z/P
-----END PGP SIGNATURE-----

--=-p/gzwMLDQkfL1tMLfaDV--

