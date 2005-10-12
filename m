Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbVJLTlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVJLTlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVJLTlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:41:40 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:29386 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750981AbVJLTlj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:41:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cCDjWYFIxDjb/V7CLfvqDPHyYIbFfbtZPqICnCV2piRj0vx+1906XWXVzIhpvsVmdaoocIc3URIfqBrPLSUe7Obp7yyGqc3l/Vo9z7l47cLJT5oEe9WtaaIqsfje6EQ/jKLrTdXcCZEljWNY4MCNzamB7QVZqwwu42474VDehKA=
Message-ID: <5bdc1c8b0510121241q526f5d4cx84c9df2ec744fec9@mail.gmail.com>
Date: Wed, 12 Oct 2005 12:41:38 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rc4-rt1
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <5bdc1c8b0510121211g5a46282fm2e34188875261bb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051011111454.GA15504@elte.hu>
	 <5bdc1c8b0510111408n4ef45eadv1e12ec4d1271d971@mail.gmail.com>
	 <5bdc1c8b0510111413q7b1ea391n3bc27924d928b963@mail.gmail.com>
	 <1129065696.4718.10.camel@mindpipe>
	 <5bdc1c8b0510120937r45bbd26fr6f45b6e3a9895d3f@mail.gmail.com>
	 <1129139304.10599.15.camel@mindpipe>
	 <5bdc1c8b0510121100o11e0e28ft4b532ba43e170774@mail.gmail.com>
	 <1129141547.11297.4.camel@mindpipe>
	 <1129142282.11410.7.camel@mindpipe>
	 <5bdc1c8b0510121211g5a46282fm2e34188875261bb7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/05, Mark Knecht <markknecht@gmail.com> wrote:
> On 10/12/05, Lee Revell <rlrevell@joe-job.com> wrote:

> I've just built with this feature. I'll try it out for a while and ask
> questions on that list while I'm configured this way.
>
> Thanks for the idea.
>
> Cheers,
> Mark
>
Ardour just segfaulted immediately when talking to jack-0.100.5 built
this way. I think I'll stick with the kernel stuff.

Any ideas on when someone might look at the IRQ-off problem in rc4-rt1
that I've reported?

Thanks,
Mark
