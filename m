Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264982AbUFMDUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264982AbUFMDUX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 23:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUFMDUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 23:20:23 -0400
Received: from dev.tequila.jp ([128.121.50.153]:15116 "EHLO dev.tequila.jp")
	by vger.kernel.org with ESMTP id S264982AbUFMDUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 23:20:20 -0400
Message-ID: <40CBC809.3000102@eunet.at>
Date: Sun, 13 Jun 2004 12:20:41 +0900
From: Clemens Schwaighofer <schwaigl@eunet.at>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: gullevek@gullevek.org, linux-kernel@vger.kernel.org, cs@tequila.co.jp
Subject: Re: compile error with 2.6.7-rc3-mm1
References: <40C9AF48.2040807@gullevek.org>	<20040611062829.574db94f.pj@sgi.com>	<40CA6835.2070405@eunet.at> <20040612034430.72a8207e.pj@sgi.com>
In-Reply-To: <20040612034430.72a8207e.pj@sgi.com>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul Jackson wrote:

|>nono, that part is already fixed in my patch (from mm-1).
|
|
| But the error you report:

Yeah _thats_ the confusing thing. The lines 100% okay, I checked that
twice, with grep and with opening the file. After I patched 2.6.6 source
with the 2.6.7-rc3 and the -mm1 patch I checked that first because I had
problems with that at office. I was surprised to see it fixed, so I made
an cp .config and make oldconfig and make bzIamge modules, but I got the
same error. So there must be something else wrong

lg, clemens

I'll be happy to help as much as I can.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAy8gJJwwYX0IeBp8RAiWRAJwIN8xCUgaiMJnxrpp8GxU1HzQzNgCgo5oq
JneEgBi5OG617ly3mNZmE4Q=
=VujH
-----END PGP SIGNATURE-----
