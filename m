Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbTIRJZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 05:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTIRJZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 05:25:42 -0400
Received: from ping.to.com ([194.221.251.37]:42254 "EHLO ping.to.com")
	by vger.kernel.org with ESMTP id S263036AbTIRJZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 05:25:40 -0400
Subject: Re: Kernel/user process communication
From: Stefan Voelkel <Stefan.Voelkel@millenux.com>
To: John R Moser <jmoser5@student.ccbc.cc.md.us>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A32.3.91.1030917233515.8136A-100000@student.ccbc.cc.md.us>
References: <Pine.A32.3.91.1030917233515.8136A-100000@student.ccbc.cc.md.us>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wet2BZ6wCbHPXZX7nvHd"
Organization: Millenux GmbH
Message-Id: <1063877101.22303.162.camel@lt-sv>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 18 Sep 2003 11:25:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wet2BZ6wCbHPXZX7nvHd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-09-18 at 05:52, John R Moser wrote:
> This may be a dumb question, but is it possible to pass data between the
> kernel and a userspace process?  I know this is probably brain-damaged in
> design, but just tell me if it's possible here.=20

There are postings on similar topics in the archive.

What comes to my mind is netlink or a device file.

	Stefan

--=-wet2BZ6wCbHPXZX7nvHd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/aXnttWF28C4HGsQRAmJ+AJ4vIg4Llc/X3V90YUz1h7ciq9Ah3ACfVvwq
//OCPLdFQkEl4P/snriXiIU=
=6zTj
-----END PGP SIGNATURE-----

--=-wet2BZ6wCbHPXZX7nvHd--

