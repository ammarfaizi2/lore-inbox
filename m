Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVGTNYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVGTNYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 09:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVGTNYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 09:24:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65459 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261198AbVGTNYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 09:24:39 -0400
Subject: Re: Memoy Management
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: =?ISO-8859-1?Q?M=E1rcio?= Oliveira <moliveira@latinsourcetech.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42DE4D2B.9090503@latinsourcetech.com>
References: <42DE4D2B.9090503@latinsourcetech.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Hrof9Tm1gjf9y2bHRTip"
Organization: Red Hat, Inc.
Date: Wed, 20 Jul 2005 09:24:34 -0400
Message-Id: <1121865874.3606.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Hrof9Tm1gjf9y2bHRTip
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-07-20 at 10:10 -0300, M=C3=A1rcio Oliveira wrote:
> Hi all,
>=20
>   Somebody can help me with some memory management issues (like Out Of=20
> Memory) in Linux kernel 2.4 (with some backports from 2.6 kernel. eg.=20
> Red Hat Enterprise Kernel) and SMP machines (4 processors) with a lot of=20
> memory (16GB)?

I'm sure RH support will be able to help you with that; I doubt many
other people care about an ancient kernel like that, and a vendor one to
boot.

(Also I assume you are using the -hugemem kernel as the documentation
recommends you to do)


--=-Hrof9Tm1gjf9y2bHRTip
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC3lCSpv2rCoFn+CIRAuIJAJ4gZlx6pUSuIx1c/hRGCz3ArNa1JACfZar8
HaKhTZmtZHuYaHf8M3mj0+w=
=sOvV
-----END PGP SIGNATURE-----

--=-Hrof9Tm1gjf9y2bHRTip--

