Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUAPU7J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUAPU7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:59:09 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:57612 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265763AbUAPU7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:59:05 -0500
Message-ID: <4008509B.2060707@techsource.com>
Date: Fri, 16 Jan 2004 15:59:07 -0500
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Redundancy eliminating file systems, breaking MD5, donating
 money to OSDL
References: <4008480F.70206@techsource.com> <200401162037.i0GKbgWY005453@turing-police.cc.vt.edu>
In-Reply-To: <200401162037.i0GKbgWY005453@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Valdis.Kletnieks@vt.edu wrote:
> On Fri, 16 Jan 2004 15:22:39 EST, Timothy Miller <miller@techsource.com>  said:
> 
> 
>>Think about it!  If we had a filesystem that actually DID this, and it 
>>was in the Linux kernel, it would spread far and wide.  It's bound to 
>>happen that someone will identify a collision.  We then report that to 
>>the committee offering the reward and then donate it to OSDL to help 
>>Linux development.
> 
> 
> Actually, it's *not* "bound to happen".  Figure out the number of blocks you'd
> need to have even a 1% chance of a birthday collision in a 2**128 space.
> 
> And you'd need that many disk blocks on *a single system*.
> 
> Then figure out the chances of a collision on a small machine that only has 20
> or 30 terabytes (yes, in this case terabytes is small).

Certainly.  No one machine is going to find it in a reasonable period. 
OTOH, if a million machines were doing it, it increases the chances by 
just that much.

