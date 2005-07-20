Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVGULox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVGULox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 07:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVGULox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 07:44:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19911 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261744AbVGULox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 07:44:53 -0400
Subject: Re: Memory Management
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: =?ISO-8859-1?Q?M=E1rcio?= Oliveira <moliveira@latinsourcetech.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42DE5E7C.6060709@latinsourcetech.com>
References: <42DE4D2B.9090503@latinsourcetech.com>
	 <1121865874.3606.13.camel@localhost.localdomain>
	 <42DE5E7C.6060709@latinsourcetech.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CBP0oQ2QszuB6OPwykRJ"
Organization: Red Hat, Inc.
Date: Wed, 20 Jul 2005 10:37:38 -0400
Message-Id: <1121870258.3606.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CBP0oQ2QszuB6OPwykRJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-07-20 at 11:23 -0300, M=C3=A1rcio Oliveira wrote:
> Arjan van de Ven wrote:
>=20
> >I'm sure RH support will be able to help you with that; I doubt many
> >other people care about an ancient kernel like that, and a vendor one to
> >boot.
> >
> >(Also I assume you are using the -hugemem kernel as the documentation
> >recommends you to do)
> >
> > =20
> >
> Arjan,
>=20
>    I'd like to know/understand more about memory management  on  Linux=20
> Kernel and I belive this concept is applyable to the Red Hat Linux Kernel=
.

Only on the highest of levels. The RHEL3 kernel has a VM that resembles
almost no other linux kernel in many many ways.=20


>   I have some doubts about the ZONE divison (DMA, NORMAL, HIGHMEM),=20
> Shared Memory utilization, HugeTLB feature and OOM with large memory and=20
> the kernel management of memory on SMP machines. I believe these=20
> features are common to the Linux kernel in general(Red Hat, Debian,=20
> SuSe, kernel.org), right?

nope. These things are very much different between the kernels you
mention.

What do you want to use the knowledge for? Fixing the VM? Tuning your
server? The goal of your question determines what kind of answer you
want to your questions....

--=-CBP0oQ2QszuB6OPwykRJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC3mGypv2rCoFn+CIRAi0oAJ9BRhKTlD4BvRSZ8Dr2Rd/X21WFTgCeKtlu
oYxngUvop3YZTNWNZPyzy/g=
=QvVi
-----END PGP SIGNATURE-----

--=-CBP0oQ2QszuB6OPwykRJ--

