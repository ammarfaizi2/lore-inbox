Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTJJIsg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbTJJIsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:48:36 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:63726 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262675AbTJJIsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:48:32 -0400
Subject: Re: Changing map for shared libraries
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Tushar Telichari <t_telichari@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <LAW14-F5V9LvuKebm4M00000d37@hotmail.com>
References: <LAW14-F5V9LvuKebm4M00000d37@hotmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hq5bORG2VszlpS/1eK9z"
Organization: Red Hat, Inc.
Message-Id: <1065775635.5433.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Fri, 10 Oct 2003 10:47:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hq5bORG2VszlpS/1eK9z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-10-10 at 10:39, Tushar Telichari wrote:
> Hi,
>=20
> I need to change the 0x40000000 (loading of shared libraries) to a differ=
ent=20
> address after it.

you can use prelink to move all libs to a location of your chosing

> My Linux kernel is 2.4.7-10

that's a very bad and old kernel with lots of local (and remote)
security holes... you really should upgrade.

--=-hq5bORG2VszlpS/1eK9z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/hnISxULwo51rQBIRAqUdAJ9903aaklTnHU6mj5YpRrzVTYY5ugCdHuN8
IHzzfMDDV51hauEHn825hjY=
=MmOg
-----END PGP SIGNATURE-----

--=-hq5bORG2VszlpS/1eK9z--
