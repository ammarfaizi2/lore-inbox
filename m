Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263232AbUEGH3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbUEGH3z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 03:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbUEGH3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 03:29:55 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:57343 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S263232AbUEGH3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 03:29:54 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
From: Ian Kumlien <pomac@vapor.com>
To: richard@techdrive.com.au
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vCn8x1+9moDkI+sZIf3B"
Message-Id: <1083914992.2797.82.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 07 May 2004 09:29:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vCn8x1+9moDkI+sZIf3B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> ASUS have now supplied a BIOS update for the A7N8X-X which fixes the=20
> C1 halt crash. dated the 2004/04/21.  So I assume that they will=20
> supply a patch for all nforce2 motherboards.

you mean the 1009 bios? It doesn't fix anything.
I'm using it and:

dmesg output:
...
Asus A7N8X-X detected: BIOS IRQ0 pin2 override will be ignored
...
PCI: nForce2 C1 Halt Disconnect fixup
...

(I'm the one that told Len about the new bios that doesn't fix the pin2
bug and afair, the C1 Halt Disconnect fix checked for flawed values, ie,
this bios dosn't fix anything...)
--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-vCn8x1+9moDkI+sZIf3B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAmzrw7F3Euyc51N8RAtuvAKC1BwGf59+Yq72UNOA0BHUHhJPaSQCfRtbM
kkA0hyBF3lWGFpUz7byz8L0=
=bi7A
-----END PGP SIGNATURE-----

--=-vCn8x1+9moDkI+sZIf3B--

