Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUEVMU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUEVMU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 08:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUEVMU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 08:20:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24000 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261159AbUEVMUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 08:20:55 -0400
Subject: Re: ioctl number 0xF3
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40AF42B3.8060107@winischhofer.net>
References: <40AF42B3.8060107@winischhofer.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wgL5VZswsxIG+8sH9PHH"
Organization: Red Hat UK
Message-Id: <1085228451.14486.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 22 May 2004 14:20:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wgL5VZswsxIG+8sH9PHH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-05-22 at 14:08, Thomas Winischhofer wrote:
> I would like to reserve ioctl's 0xF3 00-40 for the SiS framebuffer=20
> device driver (2.4 and 2.6).
>=20
> Any oppositions?

well you don't say what you want to use it for.... so nobody can see if
those ioctls should become generic, if they are 32/64 bit safe etc etc.
Might be a good idea to post the ioctl interface to the list as well.

--=-wgL5VZswsxIG+8sH9PHH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAr0WixULwo51rQBIRAiv7AKCNAWV79az/xsl1rq12gsDTF8s+vgCgqxOW
YxZPm1vLjfewayFAToEOZfw=
=ix4F
-----END PGP SIGNATURE-----

--=-wgL5VZswsxIG+8sH9PHH--

