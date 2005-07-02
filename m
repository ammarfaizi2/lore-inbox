Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVGBCmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVGBCmq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 22:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVGBCmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 22:42:45 -0400
Received: from mail.gmx.de ([213.165.64.20]:40667 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261696AbVGBCmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 22:42:37 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc1-mm1
Date: Sat, 2 Jul 2005 04:43:23 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050701044018.281b1ebd.akpm@osdl.org>
In-Reply-To: <20050701044018.281b1ebd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart15584751.ueKM99Xxqt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507020443.27889.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart15584751.ueKM99Xxqt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 01 July 2005 13:40, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc1/=
2.
>6.13-rc1-mm1/

I get this warning on modules_install:
WARNING: /lib/modules/2.6.13-rc1-mm1/kernel/net/ieee80211/ieee80211.ko need=
s=20
unknown symbol is_broadcast_ether_addr

cheers,
dominik

--nextPart15584751.ueKM99Xxqt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iQCVAwUAQsX/TwvcoSHvsHMnAQKOtwP+KyC3ckHj7lYw6Xl95wZS95fw/RHHvYkv
YlmCy98b4VJyLCK3Re9AqE0D6T5DTuF3Md8kCLJtZoT8Zg89y7n/khbN6r2epbwI
ljn3mtmwCqvabTd+VJCFung27YjfPFbKS7oi0uN4MTf8L2For07mzB9yYmJNlcWz
4ojiWePUDiY=
=6pOb
-----END PGP SIGNATURE-----

--nextPart15584751.ueKM99Xxqt--
