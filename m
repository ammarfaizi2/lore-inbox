Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268450AbUIGTAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268450AbUIGTAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268496AbUIGTAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:00:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41624 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268289AbUIGS7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:59:49 -0400
Subject: Re: [PATCH] unexport get_wchan
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1094578157.9607.25.camel@localhost.localdomain>
References: <20040907144539.GA8808@lst.de>
	 <1094576868.9607.7.camel@localhost.localdomain>
	 <20040907181130.GA12595@lst.de>
	 <1094578157.9607.25.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vNapW7pNMRkWNTzcED1R"
Organization: Red Hat UK
Message-Id: <1094583570.2801.22.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 20:59:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vNapW7pNMRkWNTzcED1R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-07 at 19:29, Alan Cox wrote:
> On Maw, 2004-09-07 at 19:11, Christoph Hellwig wrote:
> > Which debuging tool?  Both kdb and xmon don't use it.
>=20
> You broke my kgdb 8)=20

kgdb surely uses the kallsyms stuff instead... far more reliable...


--=-vNapW7pNMRkWNTzcED1R
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBPgUSxULwo51rQBIRAjM3AJoDbpGuatnw1+nycN61fZk3EKpX1gCaA063
Y3RjbES1FyFLYZd48B4LTVc=
=tb87
-----END PGP SIGNATURE-----

--=-vNapW7pNMRkWNTzcED1R--

