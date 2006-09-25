Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWIYUIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWIYUIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWIYUIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:08:51 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:56015 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750840AbWIYUIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:08:50 -0400
Message-ID: <4518374D.9060206@garzik.org>
Date: Mon, 25 Sep 2006 16:08:45 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patch] libata fix
References: <20060925193511.GA6129@havoc.gtf.org> <1159216257.11049.137.camel@localhost.localdomain>
In-Reply-To: <1159216257.11049.137.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Llu, 2006-09-25 am 15:35 -0400, ysgrifennodd Jeff Garzik:
>> [hey Linus, your git summary hint helped, thanks]
>>
>> Please pull from 'upstream-linus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus
> 
> Btw this one doesn't actually solve the FRV case. That's going to need
> some more work and thinking. Look for patches tomorrow.

It gets FRV to where it was at the point of 2.6.18 release.  Whether it 
worked on FRV at the time of 2.6.18 is quite a different question...

This recent push merely exposed _existing_ arch dependencies.  They 
aren't new by any stretch of the imagination.

As we see, the push has spurred relevant people into taking the correct 
action ;-)

	Jeff



