Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUB0BnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUB0Bk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:40:28 -0500
Received: from D70ce.d.pppool.de ([80.184.112.206]:61413 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S261711AbUB0Bjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:39:45 -0500
In-Reply-To: <20040226225131.GX5499@fs.tum.de>
References: <20040226225131.GX5499@fs.tum.de>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4-754468617"
Message-Id: <A93036A2-68C5-11D8-A46E-000A9597297C@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Daniel Egger <degger@fhm.edu>
Subject: Re: What happened to LAN Media Corporation?
Date: Fri, 27 Feb 2004 02:38:36 +0100
To: Adrian Bunk <bunk@fs.tum.de>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-4-754468617
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Feb 26, 2004, at 11:51 pm, Adrian Bunk wrote:

> LANMEDIA WAN CARD DRIVER
> P:      Andrew Stanley-Jones
> M:      asj@lanmedia.com
> W:      http://www.lanmedia.com/
> S:      Supported
		  ^^^^^^^^^
Isn't there a no joke in maintainers policy? Should be.

> But lanmedia.com seems to be for sale by buydomains.com .

Bought by SBE. And the first cool action they placed on the
market was to substitute all occurrences of LMC in the driver
by SBE and make some other incompatible changes to make sure
that the old tools wouldn't work with the "new" driver and
vice versa. Surprisingly the kernel maintainers did not like
this very much so the drivers in the latest kernels are
somewhat old and conflicting with the "real" drivers.

What's more, their driver version 3.2 doesn't compile with
2.4.21 and up, so unless they've eventually released their
highquality patch/driver/tool/utilities/extras + telnet
and more bundle in version 4.0 version which will probably
only work up to 2.4.24 anyway (due to the latest HDLC
changes), one has to stick to an old version of the driver,
which works somewhat but given the extraordinary code quality
I would be very surprised if that's a synonym for a nice
uptime.

There's something about WAN card manufacturers that seems to
say: If you hate us for the sad driver quality, check back
with our competition and then come back later...

Who's up next: Sangoma?

Servus,
       Daniel

--Apple-Mail-4-754468617
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQD6fnDBkNMiD99JrAQLtSwf7BzaZFL7PWiYh/bXxLm2DOEp8yT8Qbofq
VeZPfZy39ZllJMvd4GxWXz4u6UyfqPB46mTqSMuah1Tpy9CKBrBsIk0yIc2i7d/U
RvND1TkrIOIaLQtZoqz7JXkKdC6chUd4iaxmKLPJ8lW4stPBecmvFv1Edv02ENXX
hT7yVryJTOeyR0fvavA7qiVhtep0gEqO7EnHovxC/8aSictmyQnnUo/L0GUBsHef
gpzXATNTvpx+2yFdg8p78pcSPVdvCUvoQ4TjyABOc0CmT6Vq8cywBerIRWm2eRLs
gpx0mYo97Ccgyb6xOTj6CYnzmbkFF52H2k8L5lTZdxHYWOaARokn0Q==
=+boG
-----END PGP SIGNATURE-----

--Apple-Mail-4-754468617--

