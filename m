Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265408AbRGBS5o>; Mon, 2 Jul 2001 14:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbRGBS5e>; Mon, 2 Jul 2001 14:57:34 -0400
Received: from COD-ETH-14.WYOMING.COM ([204.227.211.254]:33009 "HELO
	noir.kain.org") by vger.kernel.org with SMTP id <S265408AbRGBS5R>;
	Mon, 2 Jul 2001 14:57:17 -0400
Date: Mon, 2 Jul 2001 12:57:14 -0600
From: Kain <kain@kain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more SAK stuff
Message-ID: <20010702125714.A2258@noir.kain.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <UTC200107021216.OAA512638.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <UTC200107021216.OAA512638.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Jul 02, 2001 at 02:16:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2001 at 02:16:36PM +0200, Andries.Brouwer@cwi.nl wrote:
> (a) It does less, namely will not kill processes with uid 0.
> Ted, any objections?
What if you have a process running wild as uid 0 (i.e. X server gone bad) t=
hat you need to die *right now*?
--=20
"Don't dwell on reality; it will only keep you from greatness."
  -- Randall McBride, Jr.
**
Evil Genius
Bryon Roche, Kain <kain@kain.org>

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7QMQKBK2G/mh4q9URAsoAAJ9AE1AvAqendX32MntoFdfiM+CETQCgp9y5
LO4By4+YyOO1CBnG7xdn0uo=
=rMfK
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
