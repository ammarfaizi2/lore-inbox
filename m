Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268340AbUIKVM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268340AbUIKVM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 17:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268322AbUIKVHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 17:07:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51851 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268326AbUIKVFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 17:05:52 -0400
Subject: Re: [PATCH 2.6.9-rc1-mm4 6/6] [m32r] Update CF/PCMCIA drivers
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040912.055123.719890756.takata@linux-m32r.org>
References: <20040912.052403.730551818.takata@linux-m32r.org>
	 <20040912.055123.719890756.takata@linux-m32r.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3mvG2YPSfsthw+XpHN4Q"
Organization: Red Hat UK
Message-Id: <1094936733.7456.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 23:05:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3mvG2YPSfsthw+XpHN4Q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-09-11 at 22:51, Hirokazu Takata wrote:
> [PATCH 2.6.9-rc1-mm4 6/6] [m32r] Update CF/PCMCIA drivers
>   This patch updates m32r-specific CF/PCMCIA drivers and=20
>   fixes compile errors.

why are these still in arch/m32r/drivers ??
please move them to drivers/pcmcia

--=-3mvG2YPSfsthw+XpHN4Q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBQ2idxULwo51rQBIRArzoAJ90HuLSTVvoXobNhUDZOch1YzIF4wCaAgVO
6oX4QCqGwCCa8H7QS8tS84Q=
=gu/W
-----END PGP SIGNATURE-----

--=-3mvG2YPSfsthw+XpHN4Q--

