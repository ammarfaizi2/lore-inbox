Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWGQRCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWGQRCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 13:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWGQRCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 13:02:43 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:11189 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751014AbWGQRCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 13:02:42 -0400
X-Sasl-enc: OlR5x0K+8NV49QIx2pxLAGl1tF5N6Iu4YkxJoj7bZuO+ 1153155755
Message-ID: <44BBC2A9.1050507@imap.cc>
Date: Mon, 17 Jul 2006 19:02:33 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc1: printk delays
References: <6vtF8-99-7@gated-at.bofh.it>  <44AD9605.6000601@imap.cc>	 <1152229599.24656.175.camel@cog.beaverton.ibm.com>	 <44ADA84A.9000603@imap.cc> <1152233897.24656.179.camel@cog.beaverton.ibm.com> <44AE7861.8090103@imap.cc>
In-Reply-To: <44AE7861.8090103@imap.cc>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig75AF1D73C05FA362AF9820AD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig75AF1D73C05FA362AF9820AD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07.07.2006 17:06, Tilman Schmidt wrote:
> john stultz wrote:
>=20
>>Hmmm. Just to make sure I understand the situation: If you log in via
>>ssh, and run dmesg, you do see your driver's output, but that output
>>just doesn't get to syslog until you press a key on your keyboard?
>=20
> Exactly.

FYI, the issue is still present in 2.6.18-rc2.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig75AF1D73C05FA362AF9820AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEu8KwMdB4Whm86/kRAlTDAJ9pFgVNch4wp9/4c9Jfbv/EU+3zwwCfdGP/
MMyUe5xHRjl4AoGFw74mwgY=
=aONm
-----END PGP SIGNATURE-----

--------------enig75AF1D73C05FA362AF9820AD--
