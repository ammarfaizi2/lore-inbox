Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUAIOWk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 09:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUAIOWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 09:22:40 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:13441 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261774AbUAIOWh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 09:22:37 -0500
Subject: Re: Odd speed problems with aic79xx drivers on RHEL
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: LKML <lkml@dongkiru.net>
Cc: linux-kernel@vger.kernel.org, gibbs@scsiguy.com
In-Reply-To: <Pine.LNX.4.44.0401081518570.5480-100000@fw.dongkiru.net>
References: <Pine.LNX.4.44.0401081518570.5480-100000@fw.dongkiru.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-euQaHB34WP1MENd63yKq"
Organization: Red Hat, Inc.
Message-Id: <1073658133.4985.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 09 Jan 2004 15:22:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-euQaHB34WP1MENd63yKq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-09 at 00:34, LKML wrote:

> I've tried recomping the Enterprise kernel with the latest aic79xx driver
> from Justin's site, with no change.  Turning TCQ turned off, I was able t=
o
> get 95MB/s read and write, but at a much higher load average of 2.9.
> Shouldn't enabling TCQ improve the speed?  Any thoughts or suggestions on
> what to try next?

how about actually calling RH support about this ? Or file a bug with
RH?=20

--=-euQaHB34WP1MENd63yKq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA//rkVxULwo51rQBIRAq1/AJ45gRSOTttfII7a6kDH65nGGIxAFQCeOxQ0
z66epF0ZqO9/Y6aeJZfNPkM=
=H8OW
-----END PGP SIGNATURE-----

--=-euQaHB34WP1MENd63yKq--
