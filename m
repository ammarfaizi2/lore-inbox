Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbTHZUSz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbTHZUSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:18:55 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.36.230]:7304 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id S262802AbTHZUSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:18:51 -0400
Subject: Re: [OOPS] less /proc/net/igmp
From: Owen Ford <oford@arghblech.com>
To: YOSHIFUJI Hideaki / =?UTF-8?Q?=E5=90=89=E8=97=A4=E8=8B=B1?=
	 =?UTF-8?Q?=E6=98=8E?= <yoshfuji@linux-ipv6.org>
Cc: sebek64@post.cz, smiler@lanil.mine.nu, jmorris@intercode.com.au,
       lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
In-Reply-To: <20030827.015448.70287953.yoshfuji@linux-ipv6.org>
References: <20030826.150331.102449369.yoshfuji@linux-ipv6.org>
	 <1061878985.3463.2.camel@spider.hotmonkeyporn.com>
	 <20030826.173226.114994096.yoshfuji@linux-ipv6.org>
	 <20030827.015448.70287953.yoshfuji@linux-ipv6.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PeS/01pZdZ+R0lb8Y0wo"
Message-Id: <1061929108.3946.1.camel@spider.hotmonkeyporn.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 26 Aug 2003 15:18:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PeS/01pZdZ+R0lb8Y0wo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-08-26 at 11:54, YOSHIFUJI Hideaki / =E5=90=89=E8=97=A4=E8=8B=
=B1=E6=98=8E wrote:
> Hello.
>=20
> In article <20030826.173226.114994096.yoshfuji@linux-ipv6.org> (at Tue, 2=
6 Aug 2003 17:32:26 +0900 (JST)), YOSHIFUJI Hideaki / =E5=90=89=E8=97=A4=E8=
=8B=B1=E6=98=8E <yoshfuji@linux-ipv6.org> says:
>=20
> > > I can confirm. I have it with 2.6.0-test4.
> > >=20
> > > Let me know what useful info I can provide.  The oops is the same.
> >=20
> > Okay, everyone. I'll try to fix this.
>=20
> Please try this patch.

That seems to have done the job nicely.  Thanks.
=20
--=20
Owen Ford <oford@arghblech.com>

--=-PeS/01pZdZ+R0lb8Y0wo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/S8CU4bjUYpnk5/QRAkl3AJ918JN3kzIZWCjhaaaDdUFUYdy7vgCgj5Q3
3XADkcptoVsOgMKthnWz9Pg=
=AORG
-----END PGP SIGNATURE-----

--=-PeS/01pZdZ+R0lb8Y0wo--

