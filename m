Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbUKNGvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUKNGvT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 01:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbUKNGvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 01:51:19 -0500
Received: from i31207.upc-i.chello.nl ([62.195.31.207]:43392 "EHLO
	laptop.fenrus.org") by vger.kernel.org with ESMTP id S261253AbUKNGvM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 01:51:12 -0500
Subject: Re: Compiling RHEL WS Kernels
From: Arjan van de Ven <arjanv@redhat.com>
To: "Paul G. Allen" <pgallen@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bd8e30a4041113222350934a3e@mail.gmail.com>
References: <bd8e30a4041113222350934a3e@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uP2XiyrCfBErrN+SpUBf"
Organization: Red Hat, Inc.
Message-Id: <1100415065.2638.0.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sun, 14 Nov 2004 07:51:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uP2XiyrCfBErrN+SpUBf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-11-13 at 22:23 -0800, Paul G. Allen wrote:
> I recently installed RHEL WS Update 3 (kernel 2.4.21-20) on my laptop.
> Out of the box it does not recognize any USB devices, my Synaptics
> touchpad, my PCMCIA Wireless (NetGear WAG511G) or the proper
> resolution on my LCD. (NOTE: RH 9 worked perfectly OOTB on this same
> machine. So far I'm not at all impressed with RHEL WS - any more than
> I was with RH 7.0.)
>=20

you might want to install the kernel-unsupported rpm

> I tried to build a new 2.4.21 kernel based upon a configuration from a
> non-RH kernel (2.4.24) that worked on this machine. Not a single
> module will compile correctly. I had to remove all modules and compile

did you start with  mrproper ?
--=20

--=-uP2XiyrCfBErrN+SpUBf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBlwBZpv2rCoFn+CIRAuZ0AKCR3lg5DxQLc1OzuEn37+8UfLNAAQCfS+gB
GsqAElnNM7c8frJnyNEB5WU=
=Nqwi
-----END PGP SIGNATURE-----

--=-uP2XiyrCfBErrN+SpUBf--
