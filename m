Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUBWR0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 12:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbUBWR0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 12:26:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:61873 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261929AbUBWR0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 12:26:03 -0500
Date: Mon, 23 Feb 2004 09:31:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Herbert Poetzl <herbert@13thfloor.at>, Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
In-Reply-To: <20040223170336.GK5499@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0402230922210.3005@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org>
 <16435.14044.182718.134404@alkaid.it.uu.se> <Pine.LNX.4.58.0402180744440.2686@home.osdl.org>
 <20040222025957.GA31813@MAIL.13thfloor.at> <Pine.LNX.4.58.0402211907100.3301@ppc970.osdl.org>
 <20040223170336.GK5499@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Feb 2004, Adrian Bunk wrote:
> 
> In the long term, x86_64 creates more confusion:
> - SuSE says AMD64 [1]
> - RedHat says AMD64 [2]
> - Debian says AMD64 [3]
> 
> Renaming might be some work today, but it might actually remove 
> confusion in the future.

Well, the thing is, I _like_ a vendor-neutral name.

I think it's important to have multiple sources for a chip, and I think 
one of the problems with IA-64 was that it was a locked-in chip with 
patents and no serious competition internally (ignore the Intel mouthing 
about "open").

The x86 is so great partly because there's been real competition. So I 
think it's very important to x86-64 to have real competition to make sure 
nobody gets too dishonest.

So AMD64 is a bad name, partly for the same reason IA32 is a horrible name 
(and who have you ever heard use the IA32 name except for people who are 
paid to do so by Intel?)

What I found so irritating is that _hours_ after the Intel announcement,
people were _still_ confused about whether the new intel chip was actually
compatible with AMD's chips. Why the f*ck not just come out and say so,
and talk about it? It took people actually reading the manuals (which
didn't mention it either) to convince some people on the architecture
newsgroups that yes, "ia32e" was really the same as "amd64" except in the
small details that have always set Intel and AMD apart.

So I don't really want to change the name. "x86-64" is a good name. I just 
wish there was more honesty involved, and less friggin *POSTURING*.

			Linus
