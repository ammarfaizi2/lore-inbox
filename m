Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbTDTSTU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTDTSTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:19:20 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:36080 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263658AbTDTSTS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:19:18 -0400
Subject: Re: irq balancing; kernel vs. userspace
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6uwuhpl2u5.fsf@zork.zork.net>
References: <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com>
	 <6uwuhpl2u5.fsf@zork.zork.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FL7VRpIJNmWXDLRwUVmD"
Organization: Red Hat, Inc.
Message-Id: <1050863476.1412.11.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 20 Apr 2003 20:31:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FL7VRpIJNmWXDLRwUVmD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-04-20 at 15:23, Sean Neakums wrote:
> I thought I'd play with the userspace IRQ-balancer, but booting with
> noirqbalance seems not to not balance.  Possibly I misunderstand how
> this all fits together.

this looks like you haven't started the userspace daemon (yet)

--=-FL7VRpIJNmWXDLRwUVmD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+oud0xULwo51rQBIRAvfXAJ9H+tWpprGnlDXWEy3m7MhUS2Fi6ACfX/bl
I/NxsTItqb0Uc8aWwlGuwuc=
=L00s
-----END PGP SIGNATURE-----

--=-FL7VRpIJNmWXDLRwUVmD--
