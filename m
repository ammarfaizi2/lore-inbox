Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbUB1Mkh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 07:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbUB1Mkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 07:40:37 -0500
Received: from D70b8.d.pppool.de ([80.184.112.184]:17551 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S261836AbUB1Mka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 07:40:30 -0500
In-Reply-To: <20040227205446.GZ5499@fs.tum.de>
References: <20040226225131.GX5499@fs.tum.de> <A93036A2-68C5-11D8-A46E-000A9597297C@fhm.edu> <20040227205446.GZ5499@fs.tum.de>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-874384198"
Message-Id: <DC71BC17-69DC-11D8-BD1F-000A9597297C@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
From: Daniel Egger <degger@fhm.edu>
Subject: Re: What happened to LAN Media Corporation?
Date: Sat, 28 Feb 2004 11:57:11 +0100
To: Adrian Bunk <bunk@fs.tum.de>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1-874384198
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Feb 27, 2004, at 9:54 pm, Adrian Bunk wrote:

> IOW:
> The entry from MAINTAINER can be removed?

This one for sure. The same is probably sensible for the
drivers, too. It's just too confusing to not several
versions of the driver floating around which need different
tools. And since the manufacturer propagates their own
version, the linux one should go...

Patch to follow shortly...

Servus,
       Daniel

--Apple-Mail-1-874384198
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQEB0DDBkNMiD99JrAQKUmwgAjuZr9H3+Blp1uAi65P8VMwYaeJDjRIb2
CcG0402vwS1JJcVEJA/yZN2Nb6pbh0+xXJ8CZ5RPcdI3GXMJiGMO8HQmo26uDwXq
vDbT908p/3C9KgaJv0WRe4L7ufcmONhYsvQtMuTYuL3mUU+1WDUru0TzAVhmnhTF
xuoq4rqNWfuR/4ikUuM9l3dLi02112H758EvchQ3IDTnaBkUSmXrinvhXIFFwjPo
d5B6w8N+nkZAlGp8K9ttIgIHpW2FN8Q+QqB8HjF0cu/PEVGqH1mCZA4ksuTx8plo
YqcIyPUW9leHncAYIu7fHGgBGa7iZx20T4Zu6Ij7g4shNY7DjnhlnQ==
=fghu
-----END PGP SIGNATURE-----

--Apple-Mail-1-874384198--

