Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUBWQnY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbUBWQnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:43:24 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:2691 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261952AbUBWQnV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:43:21 -0500
Subject: Re: Device Driver for SMP
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Jinu M." <jinum@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1118873EE1755348B4812EA29C55A97212812C@esnmail.esntechnologies.co.in>
References: <1118873EE1755348B4812EA29C55A97212812C@esnmail.esntechnologies.co.in>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-C11XXDUXUdeMzCxQ2feO"
Organization: Red Hat, Inc.
Message-Id: <1077554585.4445.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 23 Feb 2004 17:43:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-C11XXDUXUdeMzCxQ2feO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-02-23 at 17:36, Jinu M. wrote:
> Hi All,
>=20
> We have developed a PCI device driver which works well on both MAC (yello=
w dog) and x86 (RedHat) architectures.=20
> Now we need to provide the support for SMP machine. What generic changes =
will have to be made to the driver to get it working on a SMP machine.

if you coded it well, none.
But you failed to provide an URL to the source of the driver so it's
hard to say.

--=-C11XXDUXUdeMzCxQ2feO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAOi2ZxULwo51rQBIRAuV6AKCeMts7cro+b4HVY/TI5LB/JauzTgCfUnUc
KEfcRiqrdEB5AgHonx/CCu4=
=lXz1
-----END PGP SIGNATURE-----

--=-C11XXDUXUdeMzCxQ2feO--
