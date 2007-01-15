Return-Path: <linux-kernel-owner+w=401wt.eu-S1750875AbXAORJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbXAORJg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbXAORJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:09:36 -0500
Received: from mail.phnxsoft.com ([195.227.45.4]:4211 "EHLO
	posthamster.phnxsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbXAORJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:09:35 -0500
Message-ID: <45ABB53C.5030100@imap.cc>
Date: Mon, 15 Jan 2007 18:09:16 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.9) Gecko/20061211 SeaMonkey/1.0.7 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>, kkeil@suse.de
Subject: Re: any value to fixing apparent bugs in old ISDN4Linux?
References: <Pine.LNX.4.64.0701150634270.1953@CPE00045a9c397f-CM001225dbafb6>
In-Reply-To: <Pine.LNX.4.64.0701150634270.1953@CPE00045a9c397f-CM001225dbafb6>
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1016772804569C483740947D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1016772804569C483740947D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Robert P. J. Day schrieb:
>   OTOH, since that code *is* in the allegedly obsolete old ISDN4Linux
> code, perhaps that entire part of the tree can just be junked.  but if
> it's sticking around, it should probably be fixed.

Please do not remove isdn4linux just yet. It's true that it has been
marked as obsolete for quite some time, but it's still needed anyway.
Its designated successor, the CAPI subsystem, so far only supports
a very limited range of hardware. Dropping isdn4linux now would leave
the owners of some very popular ISDN cards out in the cold.

Thanks,
Tilman

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig1016772804569C483740947D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFq7VEMdB4Whm86/kRAljKAJwPOJm6XhRrszvn6IX0UdpugayGCwCfVoVA
KTXtG6aEnrUnUy2mRW927n4=
=shXx
-----END PGP SIGNATURE-----

--------------enig1016772804569C483740947D--
