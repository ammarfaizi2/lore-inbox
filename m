Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTEAI6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 04:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbTEAI6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 04:58:42 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:39150 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261180AbTEAI6l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 04:58:41 -0400
Subject: Re: [RFC] clustered apic irq affinity fix for i386
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: Keith Mannthey <kmannth@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030430163637.04f06ba6.akpm@digeo.com>
References: <1051744032.16886.80.camel@dyn9-47-17-180.beaverton.ibm.com>
	 <20030430163637.04f06ba6.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-N+l8Z6REJhVY4VDEXBPF"
Organization: 
Message-Id: <1051780253.1406.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 01 May 2003 11:10:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-N+l8Z6REJhVY4VDEXBPF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-05-01 at 01:36, Andrew Morton wrote:
> Keith Mannthey <kmannth@us.ibm.com> wrote:
> >
> > Hello all,
> > 	Machines with clustered apics are buggy when it comes to setting irq
> > affinity.
>=20
> You stand accused of crimes against whitespace.

The final verdict is: guilty. The punishment will consist of being
forced to read the sourcecode of indent for one hour.


--=-N+l8Z6REJhVY4VDEXBPF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+sOSdbpJDcQVaBT0RAulBAJsHEdSDI6UTyby9J+R5QF9LklT/sgCdFvjn
57nfh7MQSqpDxCtawNTi2M4=
=EPhB
-----END PGP SIGNATURE-----

--=-N+l8Z6REJhVY4VDEXBPF--
