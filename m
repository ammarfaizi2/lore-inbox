Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbTHUMY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 08:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbTHUMY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 08:24:29 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:18099 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262654AbTHUMY2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 08:24:28 -0400
Subject: Re: 2.6.0-test3 smp irq balance
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jens Gecius <jens@gecius.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <878yporqgy.fsf@maniac.gecius.de>
References: <878yporqgy.fsf@maniac.gecius.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mqX5h7EuztrMhPBoV2Dr"
Organization: Red Hat, Inc.
Message-Id: <1061468471.27494.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Thu, 21 Aug 2003 08:21:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mqX5h7EuztrMhPBoV2Dr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-08-20 at 17:03, Jens Gecius wrote:

>=20
> irqs seem not to be distributed between cpus, having one to handle all
> (even while building kernel on both cpus (according to gkrell), the
> numbers for the second cpu don't change.

just install and run the irqbalance daemon from:
http://people.redhat.com/arjanv/irqbalance

--=-mqX5h7EuztrMhPBoV2Dr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/RLk3xULwo51rQBIRAkI2AJ0cbGRdCPRjvFvYNR8COCwKvi5fuwCgmm04
uN2hrpvBwplINrge1mlQoFo=
=n5dn
-----END PGP SIGNATURE-----

--=-mqX5h7EuztrMhPBoV2Dr--
