Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbSLTVFp>; Fri, 20 Dec 2002 16:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265705AbSLTVFp>; Fri, 20 Dec 2002 16:05:45 -0500
Received: from splat.lanl.gov ([128.165.17.254]:16522 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S265689AbSLTVFn>; Fri, 20 Dec 2002 16:05:43 -0500
Date: Fri, 20 Dec 2002 14:13:42 -0700
From: Eric Weigle <ehw@lanl.gov>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: Which Gigabit ethernet card?
Message-ID: <20021220211342.GR23388@lanl.gov>
References: <1040391936.973.14.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dO6Thh8T/cwyDjv9"
Content-Disposition: inline
In-Reply-To: <1040391936.973.14.camel@paragon.slim>
User-Agent: Mutt/1.3.28i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dO6Thh8T/cwyDjv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FWIW-

We've used three types of GigE cards; old Alteon AceNIC (Tigon 2),
Broadcom/Tigon 3, and the el-cheapo 32 bit Intel e1000s. The Tigon 3 gives
the best performance, but the difference (600Mbps vs 750Mbps 'real-life'
performance) is generally not worth the extra cost if it's only going to be
serving NFS or something-- you probably won't be able to detect the differe=
nce.

GigE is now commodity. Check out pricewatch.
	(http://www.pricewatch.com/1/211/3732-1.htm)


-Eric

--=20
------------------------------------------------------------
        Eric H. Weigle -- http://public.lanl.gov/ehw/
"They that can give up essential liberty to obtain a little
temporary safety deserve neither" -- Benjamin Franklin
------------------------------------------------------------

--dO6Thh8T/cwyDjv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+A4gG1LDXWFnqnE8RAgL3AJ9NjNcnPoMJJlnL/gMyD3b74N7A4wCghzND
hseyj6QaLP7cOqfhui9ywH4=
=rTSI
-----END PGP SIGNATURE-----

--dO6Thh8T/cwyDjv9--
