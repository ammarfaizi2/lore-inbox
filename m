Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUGGPji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUGGPji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUGGPji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:39:38 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:42204 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265212AbUGGPj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:39:28 -0400
Message-ID: <40EC1930.7010805@comcast.net>
Date: Wed, 07 Jul 2004 11:39:28 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck kernel mailing list <ck@vds.kolivas.org>
Subject: Re: 2.6.7-ck5
References: <40EC13C5.2000101@kolivas.org>
In-Reply-To: <40EC13C5.2000101@kolivas.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Very nice, Con.  I've been using ck1 and ck3 with pax applied, and
finding performance to be exceptional.  I'll merge current 2.6.7-pax
with this and test it out right away.

When do you think the staircase, batch, and isometric scheduling will
reach mainline-quality?  Do you think you'll be ready to ask Andrew to
merge it soon, or will it be a while before it's quite ready for that?
How about autoregulated swappiness, which seems to be very efficient at
its job?

Con Kolivas wrote:
| Patchset update:
|
| These are patches designed to improve system responsiveness with
| specific emphasis on the desktop, but suitable/configurable to any
| workload. Read details and FAQ on my web page.
|
| http://kernel.kolivas.org
|

|
| Please feel free to send comments, queries, suggestions, patches.
| Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA7BkuhDd4aOud5P8RAitcAJ9OvOI9LlWlujyl3JzuQazQbzV9SQCfX7m/
oYrphGbkeT89fao/n0Y3eUA=
=i8eI
-----END PGP SIGNATURE-----
