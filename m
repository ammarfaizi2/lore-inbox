Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270725AbTGNTBD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270726AbTGNTBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:01:03 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:8947 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S270725AbTGNTA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:00:59 -0400
Subject: Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's - all needed rpms
	installed)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Trever L. Adams" <tadams-lists@myrealbox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F12FF53.7060708@pobox.com>
References: <1058196612.3353.2.camel@aurora.localdomain>
	 <3F12FF53.7060708@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/F6CDW5yLH7xwbnWPf5E"
Organization: Red Hat, Inc.
Message-Id: <1058210139.5981.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 14 Jul 2003 21:15:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/F6CDW5yLH7xwbnWPf5E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-07-14 at 21:06, Jeff Garzik wrote:
> Trever L. Adams wrote:
> > OK, I now get past the initialization of the 3c920.  However, now it
> > hangs (sak enabled, sak doesn't work... completely dead) when eth0 trie=
s
> > to come up.  I have IPv6 enabled (the router does 6to4, this isn't the
> > router), I don't believe I have any firewall stuff on this box, it does
> > dhcp for IPv4 address and ntp time.
>=20
>=20
> hmmm... do you have the latest modutils installed?

of course he has; the kernel rpm requires: a good version.

--=-/F6CDW5yLH7xwbnWPf5E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EwFbxULwo51rQBIRAmDyAKChkGk3P2L9E734DetmZ3yloiKKgwCfVBVX
gjwhKWSZnWnqSBQ7WhXBrN0=
=KfCY
-----END PGP SIGNATURE-----

--=-/F6CDW5yLH7xwbnWPf5E--
