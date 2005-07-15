Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVGOGTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVGOGTM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 02:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVGOGTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 02:19:12 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:9385 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261852AbVGOGTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 02:19:10 -0400
Subject: Re: Thread_Id
From: Ian Campbell <ijc@hellion.org.uk>
To: rvk@prodmail.net
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Arjan van de Ven <arjan@infradead.org>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42D7531F.5050901@prodmail.net>
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>
	 <42CB465E.6080104@shaw.ca> <42D5F934.6000603@prodmail.net>
	 <1121327103.3967.14.camel@laptopd505.fenrus.org>
	 <42D63916.7000007@prodmail.net>
	 <1121337567.18265.26.camel@icampbell-debian>
	 <42D6462B.8030706@prodmail.net> <1121339809.10537.6.camel@icampbell-debian>
	 <1121382144l.16874l.0l@werewolf.able.es>  <42D7531F.5050901@prodmail.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WohNyjtgZw8kRpOQlbq5"
Date: Fri, 15 Jul 2005 07:18:14 +0100
Message-Id: <1121408294.5337.14.camel@azathoth.hellion.org.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WohNyjtgZw8kRpOQlbq5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-07-15 at 11:39 +0530, RVK wrote:
> Understood on pid/tid and thread identifier diffrentiation. The question=20
> now is why pthread_t is typedef as unsigned long ?

It's just an arbitrary type that is big enough to contain the cookie.

Ian.
--=20
Ian Campbell

It is better to give than to lend, and it costs about the same.

--=-WohNyjtgZw8kRpOQlbq5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC11UmM0+0qS9rzVkRAocLAJ9om4Yi5F7BV0SNuVJgtweEwPnBUwCg0rDc
/uOdPgJI9GlHVp+p9TlPAmk=
=SGX9
-----END PGP SIGNATURE-----

--=-WohNyjtgZw8kRpOQlbq5--

