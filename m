Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbUKPOYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbUKPOYr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUKPOX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:23:57 -0500
Received: from irulan.endorphin.org ([212.13.208.107]:42253 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261967AbUKPOIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:08:38 -0500
Subject: GPL version, "at your option"?
From: Fruhwirth Clemens <clemens@endorphin.org>
To: linux-kernel@vger.kernel.org, James Morris <jmorris@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZgbU1IA0NBQcWB+ozpVk"
Date: Tue, 16 Nov 2004 15:08:35 +0100
Message-Id: <1100614115.16127.16.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZgbU1IA0NBQcWB+ozpVk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Standard template for GPL licensing:

"This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation; either version 2 of the License, or (at your
option) any later version."

As the text says, the licensee can choose the GPL version at his option,
and he is likely to choose the one with better conditions. So, newer
version can never limit the licensee's right, because he is always free
to choose version 2. Therefore, successor versions can only remove
limitations.=20

The institution to decide, how the new versions look like, is FSF. Being
totally paranoid, assume the FSF decision makers are infected by a SCO
designed virus to make them publish a new GPL version giving SCO the
right to exploit GPL covered intellectual property. And there is a lot
of the latter. Would be a classical "Duh!" situation.

I'm about to submit a patch for a new cipher mode called LRW, adding new
code/files to the crypto tree. My question is, especially to the
maintainers: Are you going to accept code covered by the terms:

 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 2 of the License.
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-ZgbU1IA0NBQcWB+ozpVk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBmgniW7sr9DEJLk4RAheJAKCJHV6E0pMmHRJfgQPfVG104jZ9xQCgjgT4
aFJtglRx7crdQKegeIL9in0=
=ZLUj
-----END PGP SIGNATURE-----

--=-ZgbU1IA0NBQcWB+ozpVk--
