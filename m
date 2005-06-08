Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVFHM0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVFHM0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 08:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVFHM0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 08:26:21 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:55246 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S262192AbVFHMZs (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 08:25:48 -0400
Subject: Re: RFC: i386: kill !4KSTACKS
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: vda@ilport.com.ua
Cc: Linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MPT5wBjhzBFwYTU8YZwD"
Date: Wed, 08 Jun 2005 14:35:17 +0200
Message-Id: <1118234117.15194.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MPT5wBjhzBFwYTU8YZwD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> Number of folks using ndiswrapper for acx100/acx111
> while acx team needs help on native driver debugging
> worries me.

two things:
	1, Broadcom chipsets lack any kind of driver.
	2, acx100/111 claim that the firm ware is 'easy to find this is a ...
lie... F.ex. d-links drivers come with the drivers embedded in some
file, i was unable to extract it for my neighbur and ended up using
ndiswrapper. There was no choise.

Thus your statement is premature.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-MPT5wBjhzBFwYTU8YZwD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBCpuYF7F3Euyc51N8RAlmPAJ0deDVXo37sWxSMHUBnnpB+yXtcqACaAsOo
jcgS6rONz+VNU7Au5IQczRQ=
=EmmX
-----END PGP SIGNATURE-----

--=-MPT5wBjhzBFwYTU8YZwD--

