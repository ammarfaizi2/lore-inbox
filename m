Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSKDIrH>; Mon, 4 Nov 2002 03:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261377AbSKDIrH>; Mon, 4 Nov 2002 03:47:07 -0500
Received: from coruscant.franken.de ([193.174.159.226]:5796 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S261339AbSKDIrG>; Mon, 4 Nov 2002 03:47:06 -0500
Date: Mon, 4 Nov 2002 09:50:40 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Georg Chini <georg.chini@triaton-webhosting.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sparc 32/64 - freeswan - iptables
Message-ID: <20021104095040.F8635@sunbeam.de.gnumonks.org>
References: <3DC5AE86.7010404@triaton-webhosting.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iQ6IArq7eFCrt6Lv"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3DC5AE86.7010404@triaton-webhosting.com>; from georg.chini@triaton-webhosting.com on Mon, Nov 04, 2002 at 12:17:26AM +0100
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.19-pre10-newnat-pptp
X-Date: Today is Pungenday, the 6th day of The Aftermath in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iQ6IArq7eFCrt6Lv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2002 at 12:17:26AM +0100, Georg Chini wrote:
> Hi,
>=20
> when I try to use freeswan on my sparcs, I have the following problems:

The question seems off-topic on the generic kernel mailinglist then.

freeswan is developed outside the kernel and not part of the kernel, it
has it's own mailinglists (see http://www.freeswan.org).

Netfilter/iptables _is_ part of the kernel but also has it's own
development-oriented mailinglist (netfilter-devel@lists.netfilter.org)

=46rom my (netfilter) point of view:  netfilter and iptables work on both
sparc32 and sparc64.  There's a single known bug in the sparc64 iptables
implementation, but it's only about the per-rule packet and byte counters.

> Can anyone help me to solve one of my problems?

As long as there's nobody pointing me more directly to a particular issue,
no. Sorry.  I don't have the time to test freeswan on a sparc system.

> Thanks in advance
>                                     Georg Chini
--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"If this were a dictatorship, it'd be a heck of a lot easier, just so long
 as I'm the dictator."  --  George W. Bush Dec 18, 2000

--iQ6IArq7eFCrt6Lv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9xjTfXaXGVTD0i/8RArLgAJwKt74q8s2zmw6C0oTEfSl9JYhl1wCeJlio
3Xi9ioHLJi9WLlVhL2/Mm1A=
=/YeA
-----END PGP SIGNATURE-----

--iQ6IArq7eFCrt6Lv--
