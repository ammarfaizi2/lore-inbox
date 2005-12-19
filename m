Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVLSVxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVLSVxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 16:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVLSVxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 16:53:13 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:18104 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932296AbVLSVxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 16:53:12 -0500
X-Sasl-enc: /wfywTU5LVlh31o0HmnzIFGlJq02O1PEd2WBnSZ/yy5g 1135029188
Message-ID: <43A72BEF.2070206@imap.cc>
Date: Mon, 19 Dec 2005 22:53:51 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Lee Revell <rlrevell@joe-job.com>, Hansjoerg Lipp <hjlipp@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] isdn4linux: add drivers for Siemens Gigaset ISDN
 DECT PABX
References: <20051212181356.GC15361@hjlipp.my-fqdn.de>	<43A6E209.5030406@imap.cc>	<1135011676.20747.3.camel@mindpipe>	<43A70882.80106@imap.cc> <20051219133022.173a8b92@localhost.localdomain>
In-Reply-To: <20051219133022.173a8b92@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig79891A145189C74F1CFA43B0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79891A145189C74F1CFA43B0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19.12.2005 22:30, Stephen Hemminger wrote:

> My definition is simple. Any device driver that exports a netdevice
> interface needs to be reviewed on netdev to make sure the assumptions
> about network device semantics are being followed.

I agree with that definition. And based on that, the Gigaset driver is
not a network device driver.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig79891A145189C74F1CFA43B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDpyv4MdB4Whm86/kRAq77AJ9n2WmP5Gv/YuLUutB1zgqTweLayQCeOej/
UgDaHHh8zAD4N0rI5jT7O+4=
=EFdR
-----END PGP SIGNATURE-----

--------------enig79891A145189C74F1CFA43B0--
