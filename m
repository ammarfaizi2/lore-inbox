Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275893AbTHOKSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275894AbTHOKSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:18:20 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:8836 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S275893AbTHOKST
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:18:19 -0400
Subject: Re: Current status of Intel PRO/Wireless 2100
From: Anders Karlsson <anders@trudheim.com>
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3CA3A0.5030905@lanil.mine.nu>
References: <3F3CA3A0.5030905@lanil.mine.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BQxDKsHD5GJdZbdR8LCv"
Organization: Trudheim Technology Limited
Message-Id: <1060942697.2296.83.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 Rubber Turnip www.usr-local-bin.org 
Date: Fri, 15 Aug 2003 11:18:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BQxDKsHD5GJdZbdR8LCv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-08-15 at 10:10, Christian Axelsson wrote:
> Whats the current status of the Intel PRO/Wireless 2100 MiniPCI?
> Some rumours says that its based upon the prisma 2.5 chip but I havent=20
> had any luck with those drivers. Intel stays passive it seems.

It is not a Prism 2.5 chipset, it is an Intel chipset that currently is
unsupported. I have not had a response from Intel in my last mail to
them, but I guess there could be holiday time there.

For the time being those mini-PCI cards is dead weight in the laptop I
am afraid. I hope that either Intel suddenly sees sense (snowflake in
hell analogy coming on) or some bright spark reverse engineers the card
and writes an alpha driver that surpasses the functionality of the Intel
beta drivers they keep under lock and key internally.

I'll probably locate some Prism CardBus card in the meantime to use.

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-BQxDKsHD5GJdZbdR8LCv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA/PLNpLYywqksgYBoRApuHAKDeg8ojRI+58uXpB+ICnUIfOL85gACg4IXM
5W+poMjirfYbY3W+uJ7rMPo=
=3vJS
-----END PGP SIGNATURE-----

--=-BQxDKsHD5GJdZbdR8LCv--

