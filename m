Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265855AbUATVqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265856AbUATVqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:46:18 -0500
Received: from 82-68-84-57.dsl.in-addr.zen.co.uk ([82.68.84.57]:38574 "EHLO
	lenin.trudheim.com") by vger.kernel.org with ESMTP id S265855AbUATVqN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:46:13 -0500
Subject: Re: BK 2.6.1 Kernel
From: Anders Karlsson <anders@trudheim.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040120181251.GC23765@srv-lnx2600.matchmail.com>
References: <1074526887.5748.8.camel@tor.trudheim.com>
	 <20040119155847.GL1748@srv-lnx2600.matchmail.com>
	 <1074609976.10034.4.camel@tor.trudheim.com>
	 <20040120181251.GC23765@srv-lnx2600.matchmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-v9yYAWdMpMDufqa2DZCd"
Organization: Trudheim Technology Limited
Message-Id: <1074635202.9075.5.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 Rubber Turnip www.usr-local-bin.org 
Date: Tue, 20 Jan 2004 21:46:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v9yYAWdMpMDufqa2DZCd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-20 at 18:12, Mike Fedyk wrote:

> Is that the taged 2.6.1 release, or does it have patches integrated after
> that tag?

That is the tagged 2.6.1 release. I looked at what change set
(1.1474.2.29) the Makefile was in when the change from 2.6.1-rc3 to
2.6.1 took place, and exported that. I could take a kernel.org tarball,
but the result will probably be exactly the same.

2.6.1 works.

2.6.1 + bk changes from
http://linux-acpi.bkbits.net:8080/linux-acpi-test-2.6.1 and
http://linux.bkbits.net:8080/linux-2.5 up until Monday 19th at about
12:00 GMT does not.

Boot params, configuration, everything as similar as can be.

> Try with a tarbal from kernel.org instead.

Will do that in the morning. Almost bed-time here. :)

Regards,

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-v9yYAWdMpMDufqa2DZCd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBADaHBLYywqksgYBoRAvCEAKCf9v0ca+E+D4tJDuDNplxMYgNWXQCghhgR
4p3TQyToBBqc/aoFaedROBs=
=/roO
-----END PGP SIGNATURE-----

--=-v9yYAWdMpMDufqa2DZCd--
