Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVFWA6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVFWA6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVFWA6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:58:46 -0400
Received: from opersys.com ([64.40.108.71]:17682 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261940AbVFWA6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:58:39 -0400
Message-ID: <42BA0BCA.6020903@opersys.com>
Date: Wed, 22 Jun 2005 21:09:30 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Ingo Molnar <mingo@elte.hu>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com> <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com> <20050623000607.GB11486@elte.hu> <42BA069D.20208@opersys.com> <20050623005538.GA3348@nietzsche.lynx.com>
In-Reply-To: <20050623005538.GA3348@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Huey (hui) wrote:
> He's probably confusing you from the real FUDers. I don't see you
> as a FUDer.

Thanks, I appreciate the vote of confidence.

> He's just resentful fighting with you over attention from the same
> batch of strippers at last years OLS. :)

But I don't want to "fight" Ingo. There would just be no point
whatsoever with "fighting" with one the best developers Linux
has. I started my involvement in these recent threads with a
very clear statement that I was open to being shown wrong in
having exclusively championed the nanokernel approach in the
past. I set out to show myself wrong with these tests and
beside some vague expectations, I truely didn't know what I
was going to find. I certainly wouldn't have bet a hot-dog on
preempt_rt coming neck-to-neck with the ipipe on interrupt
latency ... So yes, in doing so some results I've found aren't
that nice. But, hell, I didn't invent those results. They are
there for anyone to repdroduce or contradict. I have no
monopoly over LMbench, PC hardware, the Linux kernel, or
anything else used to get those numbers.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
