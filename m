Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263357AbSJFIIM>; Sun, 6 Oct 2002 04:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263358AbSJFIIM>; Sun, 6 Oct 2002 04:08:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11538 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263357AbSJFIIM>;
	Sun, 6 Oct 2002 04:08:12 -0400
Message-ID: <3D9FF09D.2080701@pobox.com>
Date: Sun, 06 Oct 2002 04:13:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Skip Ford <skip.ford@verizon.net>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
References: <AD47B5CD-D7DB-11D6-A2D4-0003939E069A@mac.com> <3D9F49D9.304@redhat.com> <20021005162852.I11375@work.bitmover.com> <1033861827.4441.31.camel@irongate.swansea.linux.org.uk> <anoivq$35b$1@penguin.transmeta.com> <200210060743.g967hEWf000528@pool-141-150-241-241.delv.east.verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip Ford wrote:
> Linus Torvalds wrote:
> 
>>I don't do any pre-patches or daily patches any more, because it's all
>>automated.  There are several snapshot bots that give you patches a lot
>>more often than "every 2 days".  You don't need BK to use it, it's there
>>in the good old diff format. 
> 
> 
> However, a much larger percentage of patches are applied to your tree
> without a diff being posted to lkml first.

IMO this is very incorrect -- the high volume submitters have never 
posted their stuff to lkml when sending to Linus.   BK did not change 
this at all.  Andrew is the notable exception.  [1]


 > My only wish would be that
> you only accept patches through the mailing list,

that won't work for many reasons...   lots of uninteresting patches 
posted to lkml, security patches should go out-of-band, etc.  Do you 
_really_ want to see boring and huge arch merges posted to lkml?  Ug.  :)

	Jeff


[1] One might argue that Ingo is another exception, but I don't count 
him among the high-volume submitters.  This is not intended to diminish 
him, either:  Ingo probably has one of the highest "important/trivial" 
patch ratios of anybody in the kernel...


