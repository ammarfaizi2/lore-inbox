Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265344AbUAADmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 22:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbUAADmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 22:42:40 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:43751 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265344AbUAADmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 22:42:35 -0500
Subject: Re: error message in dmesg
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Henti Smith <henti@geekware.co.za>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040101052029.40b10f87.henti@geekware.co.za>
References: <20040101052029.40b10f87.henti@geekware.co.za>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-txzEItLtR9Xr4/TuF4yQ"
Message-Id: <1072928707.7243.20.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 05:45:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-txzEItLtR9Xr4/TuF4yQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-01 at 05:20, Henti Smith wrote:

> ------------[ cut here ]------------
> kernel BUG at mm/slab.c:1268!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c0138825>]    Tainted: PF=20
> EFLAGS: 00010202

You will prob have to try and recreate it without the binary
driver before anybody is going to have a look ...


Regards,

--=20
Martin Schlemmer

--=-txzEItLtR9Xr4/TuF4yQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/85fDqburzKaJYLYRAidXAJ9QsamAtzelMJvLmvAS6qRDRRX4wACfZM8o
AtpWHuigNS31HhdqRFjxECE=
=y4z8
-----END PGP SIGNATURE-----

--=-txzEItLtR9Xr4/TuF4yQ--

