Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266022AbUGJIKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUGJIKX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 04:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266031AbUGJIKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 04:10:23 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:62447 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266022AbUGJIKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 04:10:21 -0400
Message-ID: <2a4f155d040710011041a95210@mail.gmail.com>
Date: Sat, 10 Jul 2004 11:10:07 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Cc: Andrea Arcangeli <andrea@suse.de>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20040710075747.GA25052@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040709235017.GP20947@dualathlon.random> <20040710075747.GA25052@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch against 2.6.7 would be more appreciated as Linus looks like
won't release 2.6.8 soon.

On Sat, 10 Jul 2004 09:57:47 +0200, Ingo Molnar <mingo@elte.hu> wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > the other bad thing is that there is no  point for the sysctl [...]
> 
>  [snipped another 30 lines of rant]
> 
> > >  (Note to kernel patch reviewers: the split voluntary_resched type of
> > >  APIs, the feature #ifdefs and runtime flags are temporary and were
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >  only introduced to enable easy benchmarking/comparisons. I'll split
>      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >  this up into small pieces once there's testing feedback and actual
> > >  audio users had their say!)
> 
>         Ingo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Time is what you make of it
