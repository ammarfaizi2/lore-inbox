Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbUC3RRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbUC3RRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:17:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8072 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263767AbUC3RQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:16:17 -0500
Subject: Re: how to avoid low memory situation
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Eli Cohen <mlxk@mellanox.co.il>
Cc: kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <4069A7DC.4060107@mellanox.co.il>
References: <4069A7DC.4060107@mellanox.co.il>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2HBHQEpgJ0vz7Qy2K23A"
Organization: Red Hat, Inc.
Message-Id: <1080666971.4679.15.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 30 Mar 2004 19:16:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2HBHQEpgJ0vz7Qy2K23A
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-03-30 at 19:01, Eli Cohen wrote:
> Hi,
> Our driver is locking user space memory by calling sys_mlock() while the=20
> processes are ordinary processes without root priviliges.

ewwwwwwwwwwwwwwwwwwwwwww

--=-2HBHQEpgJ0vz7Qy2K23A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAaatbxULwo51rQBIRAr9+AJ4hMNGhEaByrQwPjnbjgwQ89BZs8ACeKgDq
ImIWDkJRustoJ92nBs43Bcg=
=/OC+
-----END PGP SIGNATURE-----

--=-2HBHQEpgJ0vz7Qy2K23A--

