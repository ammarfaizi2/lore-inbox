Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293083AbSCBRiv>; Sat, 2 Mar 2002 12:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293230AbSCBRik>; Sat, 2 Mar 2002 12:38:40 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:54481 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S293083AbSCBRiZ>; Sat, 2 Mar 2002 12:38:25 -0500
Date: Sat, 2 Mar 2002 12:38:04 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Bongani Hlope <bonganilinux@mweb.co.za>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] #define yield() for 2.4 scheduler (anticipating O(1))
Message-ID: <20020302173804.GB4843@opeth.ath.cx>
In-Reply-To: <1015017496.2325.7.camel@localhost.localdomain> <Pine.LNX.4.44L.0203011812370.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203011812370.2181-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2002 at 06:13:49PM -0300, Rik van Riel wrote:
> On 1 Mar 2002, Bongani Hlope wrote:
>=20
> > I think Ingo is using sys_sched_yield(); instead of yield. I will still
> > be carefull about it though.
>=20
> Hmm, I guess it is kind of important to use the same name
> for yielding the CPU that ingo is using ;)

Ingo is using yield() as well.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8gQ38MwVVFhIHlU4RAgAfAJ9H2mUmVIBbgElKsDJ8ICnUBf1/owCfd+Mx
4UZAVP7lip1Yj0eVyOYXRYE=
=bObU
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
