Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264858AbUG2IWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbUG2IWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 04:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUG2IWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 04:22:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9450 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264858AbUG2IWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 04:22:07 -0400
Subject: Re: Preliminary Linux Key Infrastructure 0.01-alpha1
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: James Morris <jmorris@redhat.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       lkml List <linux-kernel@vger.kernel.org>, dhowells@redhat.com
In-Reply-To: <Xine.LNX.4.44.0407290116340.13892-100000@dhcp83-76.boston.redhat.com>
References: <Xine.LNX.4.44.0407290116340.13892-100000@dhcp83-76.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Xttx3y6+qdXVs1Wx88Y9"
Organization: Red Hat UK
Message-Id: <1091089319.2792.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 10:21:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Xttx3y6+qdXVs1Wx88Y9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I think I heard that Greg-KH had some keyring code already, so there may
> be some existing code floating around.

actually it's David Howells; he has been working on an implementation
for quite some time and posted it to lkml a bunch of times and
incorporated the reviews.... it would be interesting to see why and how
your approaches are different...

--=-Xttx3y6+qdXVs1Wx88Y9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBCLOlxULwo51rQBIRAvQyAJ9qi2xMJmWgqBFY7j4gimN/a7X34gCfSmhi
Lv/dgGtLzM80TOJ2725Zfpo=
=Hrg3
-----END PGP SIGNATURE-----

--=-Xttx3y6+qdXVs1Wx88Y9--

