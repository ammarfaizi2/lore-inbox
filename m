Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279516AbRJXKgl>; Wed, 24 Oct 2001 06:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279517AbRJXKgc>; Wed, 24 Oct 2001 06:36:32 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:30471 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S279516AbRJXKgS>;
	Wed, 24 Oct 2001 06:36:18 -0400
Date: Wed, 24 Oct 2001 14:36:34 +0400
To: Tim Hockin <thockin@sun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPT370/366 testers needed
Message-ID: <20011024143634.A16610@orbita1.ru>
In-Reply-To: <3BD5A007.C07388ED@sun.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BD5A007.C07388ED@sun.com>; from thockin@sun.com on Tue, Oct 23, 2001 at 09:51:19AM -0700
X-Uptime: 12:59pm  up 12 days,  1:09,  2 users,  load average: 0.03, 0.08, 0.08
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2001 at 09:51:19AM -0700, Tim Hockin wrote:
> All,
>=20
> We have this (attached) large patch for the HighPoint driver.=20
> Specifically, it deals with HPT370 controllers, and should make them MUCH
> more stable (Adrian spent weeks on the phone with HighPoint).
>=20
> What I'd like is for people to test this patch on other systems with
> HighPoint 370 controllers.  Also, I need people with HPT366 chips to test,
> and find any problems - we don't have HPT366 here to test.
>=20
> Volunteers?

Is this patch related to lost interrupt problem somehow ?

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE71pmyBm4rlNOo3YgRAmQbAJ9bVHnYp7nIMEBy55VVUnib+/f2wACfSVbO
hxux4Rpr1rPcOqkTpGGRCUs=
=6VXk
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
