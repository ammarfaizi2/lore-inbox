Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313137AbSDOJkm>; Mon, 15 Apr 2002 05:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313139AbSDOJkl>; Mon, 15 Apr 2002 05:40:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14605 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313137AbSDOJkk>;
	Mon, 15 Apr 2002 05:40:40 -0400
Date: Mon, 15 Apr 2002 11:40:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Morten Helgesen <admin@nextframe.net>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [COMMENTS IDE 2.5] - "idebus=66" in 2.5.8 results in "ide_setup: idebus=66 -- BAD OPTION"
Message-ID: <20020415094029.GJ12608@suse.de>
In-Reply-To: <20020415112332.A181@sexything> <3CBA8E70.5010605@evision-ventures.com> <20020415113433.B181@sexything>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Morten Helgesen wrote:
> > >One more thing, Martin - I compiled a 2.5.8 with TCQ enabled (yep, I`m 
> > >aware of the fact that this one is _really_ alpha :), and tested it for, oh 
> > >... 10 minutes ... the system gave me all sorts of funny responses - 
> > >segfaults, "inconsistency in ld.so" and so on ... would you like me to 
> > >collect 'funnies' and send them to you ? If so, just give me a hint.
> > 
> > Thats mostly Jens stuff...
> 
> ok - Jens ? 

Would love to see it! Also send me the ide bootup messages. Note that
2.5.8 has at least on irq race with tcq dma that I've fixed, but I'd
like to see the setup anyways. Did you get any dmesg errors?

-- 
Jens Axboe

