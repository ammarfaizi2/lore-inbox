Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbSK2GKr>; Fri, 29 Nov 2002 01:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbSK2GKr>; Fri, 29 Nov 2002 01:10:47 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:42843 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S266964AbSK2GKq>;
	Fri, 29 Nov 2002 01:10:46 -0500
Date: Fri, 29 Nov 2002 07:18:03 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.23-rc2 & an MCE
Message-ID: <20021129071803.A7602@jaquet.dk>
References: <20021125202033.A1212@jaquet.dk> <20021126220459.GA229@elf.ucw.cz> <3DE6A0A8.7080501@terra.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DE6A0A8.7080501@terra.com.br>; from felipewd@terra.com.br on Thu, Nov 28, 2002 at 11:03:04PM +0000
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2002 at 11:03:04PM +0000, Felipe W Damasio wrote:
> Pavel Machek wrote:
> >>The MCE (hand copied):
> >>
> >>Machine Check Exception: 000000000000004
> >>Bank 4: b200000000040151
> >>Kernel panic: CPU context corrupt
> >=20
> > Is not it trying to tell you about bad ram?
>=20
> 	Could be, though this looks like a Instruction fetch error from the=20
> Level 1 cache, doesn't it? If so, it could be caused by a faulty processo=
r.
>=20
> 	Is this the first time it happened? Could you please check your logs=20
> and send any more MCE error codes?

Hi,

I have nothing in my logs but have had three more chrashes since
my first report. Two of them I couldn't inspect since I was at
work (the machine is at home) and had my girlfriend boot the box,
but the last one was identical to the reported one.

I am getting a new processor now and hope that'll do it.

Thanks for your comments,
  Rasmus

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE95wablZJASZ6eJs4RAl8wAJ9aZvHmXp9Pis8WRAMG+0j56yjmzwCfdx/g
rt1AvHzEgD3QnDX4BS2Q7k8=
=kr2x
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
