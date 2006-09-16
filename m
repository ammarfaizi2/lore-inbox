Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751827AbWIPVXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbWIPVXw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 17:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWIPVXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 17:23:52 -0400
Received: from opersys.com ([64.40.108.71]:11015 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751813AbWIPVXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 17:23:51 -0400
Message-ID: <450C7039.20208@opersys.com>
Date: Sat, 16 Sep 2006 17:44:25 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [patch] kprobes: optimize branch placement
References: <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal> <20060916191043.GA22558@elte.hu> <20060916193745.GA29022@elte.hu> <20060916202939.GA4520@elte.hu> <20060916204342.GA5208@elte.hu>
In-Reply-To: <20060916204342.GA5208@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> the 3 speedups i did today eliminated 63% of the kprobes overhead in 
> this test.
> 
> this too shows that there's lots of performance potential even in 
> INT3-based kprobes.

So now you're resorting to your uber-talents as a kernel guru to bury
the other side? This attitude, if you permit, I find cowardly and
hypocritical. It renders a huge disservice to kernel developers at
large by making it clear to outside observers that if they do not
curry the favors of key kernel developers or submit material which is
consensual to a given line of thought then they are not welcome.

Keep on at it. The writing is on the wall for those kernel developers
who genuinely wish that outside contributors make an effort in
pushing stuff back into mainline. Keep on at it Ingo. Hack this one
to death. I know of very few people who have your clout or
understanding of the kernel intricacies to match you in such an
arms race.

Go Ingo, Go.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
