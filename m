Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbULOTfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbULOTfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbULOTfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:35:54 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:2691 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262450AbULOTfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:35:45 -0500
Message-ID: <41C09244.2030403@comcast.net>
Date: Wed, 15 Dec 2004 14:36:36 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Montavista Realtime compilation failures
References: <41BFD327.3000408@comcast.net> <20041215094954.GA19147@infradead.org>
In-Reply-To: <20041215094954.GA19147@infradead.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ahh, alright, sorry.  I remember they announced this stuff to the list,
so I thought it had reached the general interest of the LKML.

Christoph Hellwig wrote:
| On Wed, Dec 15, 2004 at 01:01:11AM -0500, John Richard Moser wrote:
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>The MontaVista patches[1] I applied to 2.6.9 are not compiling on
|>x86_64.  I'm also using a PaX pre-patch, which I don't believe is
|>interfering; there were collisions with PaX in mm/, but none of those
|>show here (they were all in .c files, not headers, so they cannot have
|>an impact here).
|
|
| I think you're much better off complaining to mvista.
|


- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBwJJDhDd4aOud5P8RAt7XAJ9LQMN8aku8f+rhmavV9MEOjH5x3gCfaHXS
By0aLOAzXPwj2YwrtopKIqQ=
=9J4g
-----END PGP SIGNATURE-----

