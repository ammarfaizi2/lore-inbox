Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTGKQt2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTGKQt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:49:28 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:47857 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264376AbTGKQtU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:49:20 -0400
Subject: Re: Linux 2.5.75
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0307110948100.3452-100000@home.osdl.org>
References: <Pine.LNX.4.44.0307110948100.3452-100000@home.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yEJe6hhTxFgehup1otB6"
Organization: Red Hat, Inc.
Message-Id: <1057943036.5806.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 11 Jul 2003 19:03:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yEJe6hhTxFgehup1otB6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-07-11 at 18:52, Linus Torvalds wrote:
\
> The same is true of x86 too, but there at least there will be test=20
> coverage even without vendor support. Vendors making their own internal=20
> distributions with pre-2.6 kernels will help on x86 too, of course. Hint=20
> hint.


fwiw there are rpms of 2.5.75 that fit in Red Hat Linux 9 (plus updated
modutils, initscripts and mkinitrd from rawhide) on
http://people.redhat.com/arjanv/2.5
for people to play with.

(the files in this location will gets updated regularly)


--=-yEJe6hhTxFgehup1otB6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Du38xULwo51rQBIRAoXPAKCcTd5YP8fW6TnyYGa8xnRYgb8jWwCff4Fb
//qOP8q6uYxbUQ9ttunzKNU=
=uTMA
-----END PGP SIGNATURE-----

--=-yEJe6hhTxFgehup1otB6--
