Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTEZXae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 19:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTEZXae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 19:30:34 -0400
Received: from adsl-66-137-214-207.dsl.stlsmo.swbell.net ([66.137.214.207]:10653
	"EHLO base.torri.linux") by vger.kernel.org with ESMTP
	id S262321AbTEZXad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 19:30:33 -0400
Subject: Finding reason for "Attempted to kill init"
From: Stephen Torri <storri@sbcglobal.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-i19SSlnqco9n6TCVhRZq"
Organization: 
Message-Id: <1053993371.17560.16.camel@base>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 26 May 2003 18:56:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-i19SSlnqco9n6TCVhRZq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I can see from kernel/exit.c where the message "Attempted to kill init"
comes from in the kernel. That is good. What would be helpful is to
deteremine where in the code the function do_exit() is called. Is there
a way to do that? I am trying to hunt down a boot failure for a kernel
on a Gentoo LiveCD. I am in communication with the developers of the
Gentoo Alpha list about this problem?

Stephen
--=20
Stephen Torri <storri@sbcglobal.net>

--=-i19SSlnqco9n6TCVhRZq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+0qmbmXRzpT81NcgRAhVKAJ0WgkW1leuLMuiRyLZ5yxyGcz/7WACdELR7
KPTUyfyavSw0ywsOPUJu2iU=
=6NH1
-----END PGP SIGNATURE-----

--=-i19SSlnqco9n6TCVhRZq--

