Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVAUWdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVAUWdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVAUWcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:32:10 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:9625 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262561AbVAUWa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:30:29 -0500
Message-ID: <41F1823B.8040409@kolivas.org>
Date: Sat, 22 Jan 2005 09:29:15 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm2
References: <20050119213818.55b14bb0.akpm@osdl.org> <41F0B807.6000606@kolivas.org> <20050121124807.GM3209@stusta.de>
In-Reply-To: <20050121124807.GM3209@stusta.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCFCC06AABEC72BD32518C6E4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCFCC06AABEC72BD32518C6E4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> On Fri, Jan 21, 2005 at 07:06:31PM +1100, Con Kolivas wrote:
> 
>>Wont boot.
>>
>>Stops after BIOS check successful.
>>Tried reverting a couple of patches mentioning boot or reboot and had no 
>>luck. Any ideas?
>>...
> 
> 
> Known bug that came from Linus' tree, already fixed in Linus' tree.
> 
> The thread discussion this bug starts with
>   http://www.ussg.iu.edu/hypermail/linux/kernel/0501.2/1132.html

Yes indeed that fixes it. Thanks!

Cheers,
Con

--------------enigCFCC06AABEC72BD32518C6E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8YI9ZUg7+tp6mRURAhGgAJ962HxNoIjmPH8fatzbUunw+sLrlACdH2fS
dxArIHR9SJOmuVKqmHqTEM8=
=Lagc
-----END PGP SIGNATURE-----

--------------enigCFCC06AABEC72BD32518C6E4--
