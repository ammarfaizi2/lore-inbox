Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUBDPTT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 10:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUBDPTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 10:19:19 -0500
Received: from port-212-202-157-212.reverse.qsc.de ([212.202.157.212]:10921
	"EHLO bender.portrix.net") by vger.kernel.org with ESMTP
	id S263088AbUBDPTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 10:19:15 -0500
Message-ID: <40210D6C.1020405@portrix.net>
Date: Wed, 04 Feb 2004 16:19:08 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031226 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Simon Gate <simon@noir.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Orinoco in 2.6.1
References: <20040204151532.0b81878d.simon@noir.se>
In-Reply-To: <20040204151532.0b81878d.simon@noir.se>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7B4E55343BF80FBA3C0C8CEB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7B4E55343BF80FBA3C0C8CEB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Simon Gate wrote:
> Hey.
> 
> Is there a patch to get the monitor function on my orinoco wireless card with 2.6.1?
> 

I last tried it with test7, but back then the patches from

http://airsnort.shmoo.com/orinocoinfo.html

just worked (applied with -p1 in the drivers/net/wireless directory).

Regards,

Jan

--------------enig7B4E55343BF80FBA3C0C8CEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAIQ1sLqMJRclVKIYRAq5AAJ9dmuO9hhYHlnUJbVDpn8lmTTon0gCfenzG
THXfjb2/goio55WIbZVatj0=
=+/tC
-----END PGP SIGNATURE-----

--------------enig7B4E55343BF80FBA3C0C8CEB--
