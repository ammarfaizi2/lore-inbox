Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbTJCXTO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbTJCXTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:19:14 -0400
Received: from dyn-ctb-203-221-74-2.webone.com.au ([203.221.74.2]:24580 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261507AbTJCXTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:19:08 -0400
Message-ID: <3F7E03E3.1090005@cyberone.com.au>
Date: Sat, 04 Oct 2003 09:18:59 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: must-fix list reconciliation
References: <3F7D3F37.1060005@cyberone.com.au>	<20031003113437.GL24824@parcelfarce.linux.theplanet.co.uk>	<20031003083640.61dcf517.rddunlap@osdl.org>	<3F7DFE52.9010400@cyberone.com.au> <20031003160224.6737b593.rddunlap@osdl.org>
In-Reply-To: <20031003160224.6737b593.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Randy.Dunlap wrote:

>On Sat, 04 Oct 2003 08:55:14 +1000 Nick Piggin <piggin@cyberone.com.au> wrote:
>
>
snip

>| 
>| To be honest I don't really like the wiki. I'd rather changes go through
>| lkml where its easier to discuss them and keep up with them. Thats just my
>| preference though. I don't know what anyone else thinks.
>
>I don't quite see how they belong in the kernel source tree,
>although I don't mind...  That's not where I would expect to find
>the list, though.  I would expect it more on kernel.org e.g.
>

I don't know what the criteria is. It would help lazy people send 
patches. If
its in the tree they might, if they have to check if they've got the newest
version and download it from somewhere else, they won't.

I was thinking it could become a criteria (obviously with exceptions) for
feature / code freezes. I don't know what Linus or Andrew or anyone else 
think
about this though.


snip

>
>| 
>| Yes, and even easier if there was just one editor.
>| eg. there 2 drivers/acpi sections in the mustfix list on wiki.
>
>One editor if it's in a "file" vs. being in a wiki.
>

Well if its on the wiki you still need a janitor at least. The shouldfix 
list
there is beginning to look like peoples' personal todo lists.

>
>| I'd like to keep the 2 lists seperate. The must-fix list is concise and easy
>| to scan the whole thing. I guess this isn't a problem if there is one 
>| editor.
>| 
>
snip

>| 
>| If it ends up going into a source tree, I can be the editor / maintainer.
>
>of only must-fix and not should-fix??
>I wouldn't want to see should-fix abandoned.
>

No, both


