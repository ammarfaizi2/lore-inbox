Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWCODFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWCODFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 22:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbWCODFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 22:05:14 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:7331 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932588AbWCODFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 22:05:13 -0500
Message-ID: <44178429.90808@comcast.net>
Date: Tue, 14 Mar 2006 22:04:09 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ORMAP
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

And looking through the recent discussions I see in one thread...

Willy Tarreau wrote:

> It depends a lot on what people do with it in fact. For instance, it
> works better in memory-constrained systems, probably thanks to rmap.
> I have one 2.6 running reliably on my web server (hppa) where 2.4
> regularly oopsed because of low memory.


This reminds me, what the hell ever happened to ORMAP?  That object
based rmap thingy I tried out in one of wli's patches made my system
boot like 3 times faster.  There were other cool things going on that I
never got to try too, never saw that all out to fruition.

Status on some of the elements in the old 2.6-wli series from around
there would be nice.  I'm curious as to what has gone in.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRBeEKAs1xW0HCTEFAQJoiQ/+OPwYFP74F9Ysmbb9aLgUOxCo8gEfbK35
iHHVjNYDqGpoPm/yVy9tf/ilbtrbhk8NCP6q19AN7Z+8gpV8l5ITJBgJFdrtuRYv
aIqEwsqySk/mNkq7u91OnOpXFJVVlUsbALUPDistPUAGCkzcWp4M8qRmpdfbUBEO
TiZp/oWjI97nMD7bOSJf+YnzmVU9XBYQZ7mMSpX9JeP9skUjq1/kXj6hFg5w+vF/
73xZtjkntxQIvTW7mb7gQB3eNFUmY9A31ngY1Q3Maleu52FgSTNNOpb5rHUivmnl
C9ols4z9b7i+utUM8+4V527DO2JejfFEygQ8VvXLjx7luIM+dmgHYzWQaDrFkPB7
JWiCaizulRE35BEb7YVog3sfFDl0wG3/NnXGjfHdJAgALhL6JPOsLTZHvgfua7Ws
7hDDo9BvAYN5nU0kQ+EmLAAJWAQ/UL1TSKPAdsXfRGQHBrpEbyoVCfDw8D5T8r5X
ytgl+jo51WAd/dvnq+xUjnWYPauRxaRimy5xndRgEEIRCd4sxCEdmKMMxGIuRyhS
l+oPhGL+RN0wpgFHdStQ4llDF+7mu3Y3sEFrvXlIY95dmRvU5V4Y6kGTsCoChixT
5VYXWtmL2m95ywYHdyRLPJ35Z1oqVIs2s5f4YtsDLd6kpRK0B0s0EpJGQcwVvyFl
Mmnf+j31oTE=
=O+f2
-----END PGP SIGNATURE-----
