Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbTCQEFB>; Sun, 16 Mar 2003 23:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262777AbTCQEFB>; Sun, 16 Mar 2003 23:05:01 -0500
Received: from adsl-67-121-154-32.dsl.pltn13.pacbell.net ([67.121.154.32]:8672
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id <S262685AbTCQEFA>; Sun, 16 Mar 2003 23:05:00 -0500
Date: Sun, 16 Mar 2003 20:15:53 -0800
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Weirdness with 2.4.20-ck4
Message-ID: <20030317041553.GA1186@triplehelix.org>
References: <20030316201124.GA2849@triplehelix.org> <200303171509.34696.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <200303171509.34696.kernel@kolivas.org>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2003 at 03:09:23PM +1100, Con Kolivas wrote:
> Using it on a server box? You should reverse patch the desktop tuning (pa=
tch=20
> 010) at the very least. Your throughput will be higher without that and i=
t=20
> may well be responsible for the hang.

I'm running 2.4.20-rmap15e for now, but I'm quite sure I only had 001,
002, and 003.

001_o1_pe_ll_030206_ck_2.4.20.patch.bz2
002_aavm_030226_ck_2.4.20.patch.bz2
003_rl2_021215_ck.2.4.20.patch.bz2

Regards,
Josh

--=20
New PGP public key: 0x27AFC3EE

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+dUv5T2bz5yevw+4RAqy2AJ9vdUKMz0x/Gpvl61Fu2LPhspcoMACfX1cF
y4+9stRNrpSy1NKfdTmBYGA=
=igIf
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
