Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265191AbUAJOzh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 09:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUAJOzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 09:55:36 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:3256 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265191AbUAJOze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 09:55:34 -0500
Message-ID: <4000125A.3020108@yahoo.es>
Date: Sat, 10 Jan 2004 09:55:22 -0500
From: Roberto Sanchez <rcsanchez97@yahoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm2
References: <20040110014542.2acdb968.akpm@osdl.org>
In-Reply-To: <20040110014542.2acdb968.akpm@osdl.org>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDE0B507CD424250292161865"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE0B507CD424250292161865
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm2/
> 

I am still seeng the constant lockups that started with -rc2-mm1.
For the moment I have reverted to -rc1-mm1.  My setup:

Athlon XP 2500+
1 GB memory
nForce2 mobo at 333MHz FSB

If there is anything I can do to help track this down, please
let me know.  But, I am not yet much of a kernel hacker, so I
will need instruction.

-Roberto Sanchez

--------------enigDE0B507CD424250292161865
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAABJkTfhoonTOp2oRAsHAAKDQh++LpXGNlTL9XbZTrbuIXgWb8QCfV7dc
F4yiGwRTP5NSoMiFxgXzduA=
=MVFz
-----END PGP SIGNATURE-----

--------------enigDE0B507CD424250292161865--
