Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263672AbTEJHjs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 03:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263673AbTEJHjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 03:39:48 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:60839 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263672AbTEJHjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 03:39:46 -0400
Date: Sat, 10 May 2003 10:52:20 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Olivier Dragon <dragon@shadnet.shad.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linking error in sounddrivers.o (2.4.20)
Message-ID: <20030510075220.GC31003@actcom.co.il>
References: <20030510012805.GA1037@dragon.homelinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <20030510012805.GA1037@dragon.homelinux.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2003 at 09:28:05PM -0400, Olivier Dragon wrote:
> Greetings,
>=20
> In the 2.4.20 kernel I have encountered a linking error happening in
> sounddrivers.o. It happens with the following config file when doing
> "make bzImage". It first happened with a ck6 patched kernel but I have
> verified on two different computers (laptop running knoppix 3.2 and
> desktop running Debian unstable) that it also happens in the unpatched
> vanilla kernel.
>=20
> http://dragon.homelinux.org/linux-2.4.20-ck6-config

Does it still happen with 2.4.21-rc2? Also, could you please send me
in private the .config? I get a 504 gateway error when trying to wget
it.=20

> Gnu C                  3.2.3

That's a fairly experimental kernel for compiling kernels. You might
want to stick with 2.95 for the time being.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+vK+0KRs727/VN8sRAtTVAJ0XWGpJXywK/vudVCb4IobgeY5nTwCfX7sv
JMN/hRgfbocRr/qLFCET/88=
=Sw+N
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
