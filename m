Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266912AbUFZB3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266912AbUFZB3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 21:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266913AbUFZB3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 21:29:12 -0400
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:16832 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266912AbUFZB3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 21:29:09 -0400
Message-ID: <40DCD152.8050903@kolivas.org>
Date: Sat, 26 Jun 2004 11:28:50 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <40DC38D0.9070905@kolivas.org> <pan.2004.06.25.18.32.36.821877@smurf.noris.de>
In-Reply-To: <pan.2004.06.25.18.32.36.821877@smurf.noris.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Matthias Urlichs wrote:
| Con Kolivas wrote:
|
|
|>+// interactive - interactive tasks get longer intervals at best
|>priority
|
|
| Hmmm... IIRC, C++ comments are frowned upon in the kernel.

Good point. I will fatten it up with generous kernel style comments.
|
| Other than that: thanks for the work. Your comments seem to indicate that
| INYO the staircase scheduler is ready for "real-world" kernels. Correct?

Almost. I needed wider audience testing which already has revealed two
bugs it seems. Watch this space.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3NA0ZUg7+tp6mRURAnQCAKCAPG26O0YXCm75zjxnUBfm2N+UswCfeMxN
NaguMXecXIIOeAl72wLYcRQ=
=By+w
-----END PGP SIGNATURE-----
