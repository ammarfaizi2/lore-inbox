Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVA1JQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVA1JQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 04:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVA1JQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 04:16:46 -0500
Received: from xs4all.vs19.net ([213.84.236.198]:49214 "EHLO xs4all.vs19.net")
	by vger.kernel.org with ESMTP id S261241AbVA1JPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 04:15:10 -0500
Date: Fri, 28 Jan 2005 10:14:58 +0100
From: Jasper Spaans <jasper@vs19.net>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ajgrothe@yahoo.com, bunk@stusta.de
Subject: Re: crypto algoritms failing?
Message-ID: <20050128091458.GA4075@spaans.vs19.net>
References: <20050128004755.GA6676@spaans.vs19.net> <Xine.LNX.4.44.0501272023080.7174-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0501272023080.7174-100000@thoron.boston.redhat.com>
X-Copyright: Copyright 2005 Jasper Spaans, unauthorised distribution prohibited
User-Agent: Mutt/1.5.6+20040907i
X-Broken-Reverse-DNS: no host name found for IP address 192.168.0.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 27, 2005 at 08:43:18PM -0500, James Morris wrote:

> Looks like a cleanup broke the test vectors:
> http://linux.bkbits.net:8080/linux-2.5/gnupatch@41ad5cd9EXGuUhmmotTFBIZdI=
kTm0A
>=20
> Patch below, please apply.

That fixes it, thanks.

--=20
Jasper Spaans                                       http://jsp.vs19.net/
 10:13:13 up 10208 days,  2:00, 0 users, load average: 6.00 6.00 6.12

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB+gKSN+t4ZIsVDPgRAuzGAJ0ZUtedQov+KF4ZmPYlkZrrv4xPMACg5CXw
UULNXppYchzM4hrUwhplHm0=
=lE9l
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
