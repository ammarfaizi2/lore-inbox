Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUHBJjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUHBJjl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 05:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266389AbUHBJjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 05:39:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15567 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266386AbUHBJjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 05:39:39 -0400
Subject: Re: Oops in register_chrdev, what did I do?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <yw1xllgxg9v4.fsf@kth.se>
References: <yw1xwu0i1vcp.fsf@kth.se>  <yw1xllgxg9v4.fsf@kth.se>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8DExZGsY5pyt7RmzGqZ5"
Organization: Red Hat UK
Message-Id: <1091439574.2826.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 02 Aug 2004 11:39:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8DExZGsY5pyt7RmzGqZ5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> OTOH, wouldn't it be a good idea to refuse loading modules not
> matching the running kernel?

we do that already... provided you use the kbuild infrastructure instead
of a broken self-made makefile hack....

--=-8DExZGsY5pyt7RmzGqZ5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBDgvWxULwo51rQBIRAtwMAJ9IHPx/F9J2jXhbV9wWsY+LlfzUMgCfUb5c
mZJerbz7BUYFNZN3VfHtwiA=
=dkaM
-----END PGP SIGNATURE-----

--=-8DExZGsY5pyt7RmzGqZ5--

