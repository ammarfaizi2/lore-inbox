Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWIPQiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWIPQiN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 12:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWIPQiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 12:38:13 -0400
Received: from 1wt.eu ([62.212.114.60]:48402 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S964832AbWIPQiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 12:38:12 -0400
Date: Sat, 16 Sep 2006 18:22:57 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Tom Mortensen <tmmlkml@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.x libata resync
Message-ID: <20060916162257.GC18409@1wt.eu>
References: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com> <20060916053713.GJ541@1wt.eu> <450B9940.5030609@gmail.com> <20060916063808.GK541@1wt.eu> <450C1CF2.4080308@garzik.org> <20060916155141.GA18409@1wt.eu> <450C2134.7040200@garzik.org> <20060916160520.GB18409@1wt.eu> <450C25F5.1020307@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450C25F5.1020307@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2006 at 12:27:33PM -0400, Jeff Garzik wrote:
> Willy Tarreau wrote:
> >Of course for those. I was thinking about those which just change one
> >register or things like this that I cannot identify the expected effect.
> >If you agree, I'll enumerate the ones I've already noticed so that you
> >just have to say yes/no/unknown on them. Don't worry, I don't want to
> >spend lots of hours on this, since as I said, I do not receive any
> >feedback from SATA users on 2.4 (neither positive nor negative).
> 
> 
> I'm more than happy to review any 2.4 libata patches people post.

OK, I will check what I found in 2.6 when I have time.

Thanks,
Willy

