Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318707AbSHAL4p>; Thu, 1 Aug 2002 07:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318708AbSHAL4p>; Thu, 1 Aug 2002 07:56:45 -0400
Received: from host213-121-105-75.in-addr.btopenworld.com ([213.121.105.75]:52666
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S318707AbSHAL4o>; Thu, 1 Aug 2002 07:56:44 -0400
Subject: Re: network driver informations [general NIC, Wireless and e100]
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Nico Schottelius <nico-mutt@schottelius.org>
Cc: linux.nics@intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020731212426.GA3342@schottelius.org>
References: <20020731212426.GA3342@schottelius.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-OZudhakOYNZz//Prx/hj"
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 01 Aug 2002 13:00:15 +0100
Message-Id: <1028203217.32264.44.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OZudhakOYNZz//Prx/hj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-07-31 at 22:24, Nico Schottelius wrote:
> Hello!
>=20
> I recently tried the e100 driver and was happy that it reports
> if there is a connection and speed and so on.
>=20
> But should these informations not be reported through /proc-fs ?
> I think this would make it easier for programs to monitor connection
> status. We could even have a small red/green light in the KDE panel
> to display connection status for different cards.

AFAIK this information is already available for ethernet cards with an
MII tranciever via a bunch of ioctl()'s. Google for mii-diag.c for an
example.

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-OZudhakOYNZz//Prx/hj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9SSLPkbV2aYZGvn0RAmm0AJ9H34X4U/qKFI3nBPmCvobcn1bCcwCdEHca
/ZBeIR73n+W13aoiqYOtV0k=
=LRob
-----END PGP SIGNATURE-----

--=-OZudhakOYNZz//Prx/hj--

