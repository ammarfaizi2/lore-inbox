Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUDEToU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 15:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUDEToU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 15:44:20 -0400
Received: from smtp-hub2.mrf.mail.rcn.net ([207.172.4.76]:11229 "EHLO
	smtp-hub2.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S263173AbUDEToS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 15:44:18 -0400
Message-ID: <4071B70E.3090400@lycos.com>
Date: Mon, 05 Apr 2004 15:44:14 -0400
From: James Vega <vega_james@lycos.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: fat32 all upper-case filename problem
References: <4070910E.7020808@lycos.com> <87k70utw5n.fsf@devron.myhome.or.jp>
In-Reply-To: <87k70utw5n.fsf@devron.myhome.or.jp>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA25D9CB6EB51B71197ABAC1B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA25D9CB6EB51B71197ABAC1B
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

OGAWA Hirofumi wrote:
  > Are you using the "iocharset=utf8" or CONFIG_NLS_DEFAULT="utf8"?
> If so, it's buggy.
> 
> Please don't use it for now.

I am using CONFIG_NLS_DEFAULT="utf8". I'll see if I get the same results that 
changed back to iso8859-1.

--------------enigA25D9CB6EB51B71197ABAC1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iEYEARECAAYFAkBxtw4ACgkQDb3UpmEybUDR/ACffeasqPVl4xtNjYxOxf2c8Tio
VU8AnjmLLgWibdBQO/af56aeAUnwJEb7
=hN5l
-----END PGP SIGNATURE-----

--------------enigA25D9CB6EB51B71197ABAC1B--
