Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132602AbRAQTYA>; Wed, 17 Jan 2001 14:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135217AbRAQTXu>; Wed, 17 Jan 2001 14:23:50 -0500
Received: from kea.grace.cri.nz ([131.203.4.51]:3341 "EHLO kea.grace.cri.nz")
	by vger.kernel.org with ESMTP id <S132602AbRAQTXe>;
	Wed, 17 Jan 2001 14:23:34 -0500
Date: Wed, 17 Jan 2001 14:22:05 -0500 (EST)
Message-Id: <200101171922.OAA11493@whio.grace.cri.nz>
From: roger@kea.grace.cri.nz
To: jjs@pobox.com
CC: linux-kernel@vger.kernel.org, roger@kea.grace.cri.nz
In-Reply-To: <3A65ED19.444618C6@pobox.com> (message from J Sloan on Wed, 17 Jan 2001 11:06:01 -0800)
Subject: Re: [OT]: Linux v.2.4.0 and Netscape 4.76?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



J Sloan wrote:

>Just a data point - Netscape 4.76 is working wonderfully
>for me on several 2.4.x systems - well, netscape does die
>fairly often with bus errors, but when it's running it runs well -

I can be a little more specific on this point. Netscape with
kernel 2.4.0 _does_ connect/download at a few local (New Zealand)
web sites (maybe 10% of those I've tried). I can't download
from _any_ distant site. It doesn't die, it just doesn't function
properly.


Several people have suggested I remove ECN from the kernel, or
disable it. Well, ECN has never been selected as a config option
in the kernel, so this is not the source of the problem....


Thanks for your suggestion,
Roger Young.

......................................................................
roger@kea.grace.cri.nz wrote:

> The problem: symptoms
>
> It concerns the behaviour of Netscape after upgrading from kernel
> 2.2.16 to 2.4.0. With the new kernel Netscape locates and connects to
> a URL, and sometimes begins to download, but then it just sits there
> indefinitely (without downloading any data).

Just a data point - Netscape 4.76 is working wonderfully
for me on several 2.4.x systems - well, netscape does die
fairly often with bus errors, but when it's running it runs well -

jjs


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
