Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTD2NOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 09:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbTD2NOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 09:14:05 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:29168 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261994AbTD2NOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 09:14:03 -0400
Subject: Re: Stack Trace dump in do_IRQ
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: chandrasekhar.nagaraj@patni.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NHBBIPBFKBJLCPPIPIBCCEAICAAA.chandrasekhar.nagaraj@patni.com>
References: <NHBBIPBFKBJLCPPIPIBCCEAICAAA.chandrasekhar.nagaraj@patni.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-puw4LZhjSCPIXWvGKZsk"
Organization: Red Hat, Inc.
Message-Id: <1051622769.1405.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 29 Apr 2003 15:26:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-puw4LZhjSCPIXWvGKZsk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-04-29 at 14:34, Chandrasekhar wrote:
> Hi All,
> We have a custom driver which runs on Red Hat Advanced Server 2.1(kernel
> version 2.4.9-e.3).

What's the URL to the source ?

> On loading  the driver (using insmod) and running our configuration progr=
am,
> we got folowing warning message "do_IRQ: stack overflow: 1786" and along
> with the stack trace.
>=20
this is a driver bug, it's < 5 minutes to fix usually given the source
;)



--=-puw4LZhjSCPIXWvGKZsk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+rn1xxULwo51rQBIRApX4AJ9RU1WHj3vipzAip8q7Dll3wUIOQwCfcsnm
DZhdM9HCuYWOlZ4eIv9/oBk=
=7RsB
-----END PGP SIGNATURE-----

--=-puw4LZhjSCPIXWvGKZsk--
