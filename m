Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTLETXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTLETXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:23:13 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:6789 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264371AbTLETXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:23:11 -0500
Subject: Re: Linux GPL and binary module exception clause?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Valdis.Kletnieks@vt.edu
Cc: Kendall Bennett <KendallB@scitechsoft.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200312051909.hB5J9fps019007@turing-police.cc.vt.edu>
References: <MDEHLPKNGKAHNMBLJOLKMEIDIHAA.davids@webmaster.com>
	 <3FD06172.28193.4801EF18@localhost>
	 <200312051909.hB5J9fps019007@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qFwbH8NxAuhrPgMMW/pn"
Organization: Red Hat, Inc.
Message-Id: <1070652154.14996.10.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 05 Dec 2003 20:22:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qFwbH8NxAuhrPgMMW/pn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-12-05 at 20:09, Valdis.Kletnieks@vt.edu wrote:
\
> Interestingly enough, at least on my Fedora box, 'rpm -qi' reports glibc =
as LGPL,
> but glibc-kernheaders as GPL, which seems right to me - linking against g=
libc gives
> the LGPL semantics as we'd want, but forces userspace that's poking in th=
e kernel
> to be GPL as a derived work....

but those headers do not have inlines etc etc=20
just the bare minimum of structures and defines (neither of which result
in code in the binary )

--=-qFwbH8NxAuhrPgMMW/pn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0Nr5xULwo51rQBIRAilrAKCkrxAg4ZvYgCq7QX+yY4duvl/DFwCgl7hv
6MXyGO/QD4pDyOqx3h7xgus=
=wyfm
-----END PGP SIGNATURE-----

--=-qFwbH8NxAuhrPgMMW/pn--
