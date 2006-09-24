Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWIXV4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWIXV4W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWIXV4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:56:22 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:1978 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751622AbWIXV4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:56:21 -0400
X-Sasl-enc: axBHpEQjEHonoZX26/uAR2LDdjagOR89jpLKRGDs/4lr 1159134983
Message-ID: <4516FF6E.6010706@imap.cc>
Date: Sun, 24 Sep 2006 23:58:06 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.18-mm1] slow boot (was: [2.6.18-rc7-mm1] slow boot)
References: <4516B966.3010909@imap.cc>
In-Reply-To: <4516B966.3010909@imap.cc>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig70A45BF2EBF276D2F12C25EF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig70A45BF2EBF276D2F12C25EF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 24.09.2006 18:59, /me wrote:
> FYI: On my Dell OptiPlex GX110 (Intel Pentium III, 933 MHz, 512 MB
> RAM, i810 chipset), kernel 2.6.18-rc7-mm1 takes drastically longer
> to boot than 2.6.18 mainline release. [...]
> In the end, the mm kernel has taken twice as much time to get up
> and running as the mainline kernel.

Just re-tested with release 2.6.18-mm1 and it exhibits the same
behaviour as -rc7-mm1.

HTH
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enig70A45BF2EBF276D2F12C25EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFFv9uMdB4Whm86/kRAmAyAJ4q52YlNmOrOD0islYgFKx7hSPsFwCfZKh7
a0Pqc42ZDAqI3VDNbD0sgA4=
=fsHU
-----END PGP SIGNATURE-----

--------------enig70A45BF2EBF276D2F12C25EF--
