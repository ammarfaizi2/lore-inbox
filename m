Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUEXHFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUEXHFd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUEXHFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:05:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30616 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261239AbUEXHFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:05:19 -0400
Subject: Re: 4g/4g for 2.6.6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Phy Prabab <phyprabab@yahoo.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040523215519.48712.qmail@web90008.mail.scd.yahoo.com>
References: <20040523215519.48712.qmail@web90008.mail.scd.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YbliFrT6/IxkhIIomXBN"
Organization: Red Hat UK
Message-Id: <1085382314.2780.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 May 2004 09:05:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YbliFrT6/IxkhIIomXBN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-05-23 at 23:55, Phy Prabab wrote:
> So do I understand this correctly, in 2.6.7(+) it will
> no longer be necessary to have the 4g patches?  I will
> be able to get 4g/process with the going forward
> kernels?

The kernel RPMs I do (http://people.redhat.com/arjanv/2.6/) pretty much
will have it always for 2.6. Not just for large memory configs, but
because several userspace applications (databases, java etc) really like
that extra Gb of virtual space too.=20
As for the cost; 4:4 split seems to be hardly expensive at all, only in
some microbenchmarks.

--=-YbliFrT6/IxkhIIomXBN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAsZ6qxULwo51rQBIRAu0YAJ4xPh7FQa/SWz7nRAXeg5dz7HWfPACfSeSw
06aZ/CXX+iscXwGbiGZDHbU=
=7geg
-----END PGP SIGNATURE-----

--=-YbliFrT6/IxkhIIomXBN--

