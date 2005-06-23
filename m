Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVFWEDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVFWEDA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 00:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVFWEDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 00:03:00 -0400
Received: from opersys.com ([64.40.108.71]:22788 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262026AbVFWEC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 00:02:58 -0400
Message-ID: <42BA36FC.5010408@opersys.com>
Date: Thu, 23 Jun 2005 00:13:48 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, Bill Huey <bhuey@lnxw.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost>	 <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com>	 <20050622192927.GA13817@nietzsche.lynx.com>	 <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com>	 <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com>	 <20050623000607.GB11486@elte.hu> <42BA069D.20208@opersys.com>	 <20050623013451.GA14137@elte.hu>  <42BA1850.4060505@opersys.com> <1119499041.25270.38.camel@mindpipe>
In-Reply-To: <1119499041.25270.38.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lee Revell wrote:
> Are you talking about the first run where you left all those expensive
> PREEMPT_RT debug options enabled?
> 
> IMHO those numbers should be taken down, they're completely meaningless.

That's just flamebait. Anyone who's ever read an LKML thread knows
better than to just trust the topmost parent. As for those who
don't read LKML very often, then the "Latest Results" is the section
they'll be most interested in and that specific section starts with
with a big fat warning.

You can label the results meaningless if you wish, suit yourself.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
