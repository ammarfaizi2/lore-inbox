Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVIIMO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVIIMO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVIIMO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:14:57 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:12501 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932520AbVIIMO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:14:57 -0400
Message-ID: <43217C7E.7060809@fulhack.info>
Date: Fri, 09 Sep 2005 14:13:50 +0200
From: Henrik Persson <root@fulhack.info>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 0/9] -stable review
References: <20050908012842.299637000@localhost.localdomain>
In-Reply-To: <20050908012842.299637000@localhost.localdomain>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEA257A0F67D4108C8B345568"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEA257A0F67D4108C8B345568
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wright wrote:
> This is the start of the stable review cycle for the 2.6.13.1 release.
> There are 9 patches in this series, all will be posted as a response to
> this one.  If anyone has any issues with these being applied, please let
> us know.  If anyone is a maintainer of the proper subsystem, and wants
> to add a signed-off-by: line to the patch, please respond with it.
*snip*

I didn't see the patch from Ivan Kokshaysky ( 
http://marc.theaimsgroup.com/?l=linux-kernel&m=112541348008047&w=2 ) 
included.. Without this one my laptop will freeze and die when inserting 
a something into the cardbus slot, so I would say that it would kind of 
fit in there.

Any reason why it's not included?

--
Henrik

--------------enigEA257A0F67D4108C8B345568
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDIXyDp5uk1YPOcmcRAjqEAJ90sdLlw+KKR+Z2RUKNgYcAhTmwVQCgnbuN
CTvYw05pCflwNP5KajDnP+A=
=h3Ww
-----END PGP SIGNATURE-----

--------------enigEA257A0F67D4108C8B345568--
