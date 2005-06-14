Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVFNDOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVFNDOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 23:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVFNDOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 23:14:22 -0400
Received: from opersys.com ([64.40.108.71]:39952 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261393AbVFNDOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 23:14:15 -0400
Message-ID: <42AE4DDB.2040603@opersys.com>
Date: Mon, 13 Jun 2005 23:24:11 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Nicolas Pitre <nico@cam.org>
CC: "Bill Huey (hui)" <bhuey@lnxw.com>, dwalker@mvista.com, paulmck@us.ibm.com,
       Andrea Arcangeli <andrea@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, lkml <linux-kernel@vger.kernel.org>,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com> <42ADE334.4030002@opersys.com> <1118693033.2725.21.camel@dhcp153.mvista.com> <42ADEC0E.4020907@opersys.com> <1118694495.2725.32.camel@dhcp153.mvista.com> <42AE01EA.10905@opersys.com> <42AE04AE.8070107@opersys.com> <20050613221810.GA820@nietzsche.lynx.com> <42AE0875.8010001@opersys.com> <20050613222909.GA880@nietzsche.lynx.com> <42AE0EF8.1090509@opersys.com> <Pine.LNX.4.63.0506132052590.1667@localhost.localdomain> <42AE3BEB.2070309@opersys.com> <Pine.LNX.4.63.0506132204460.1667@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.63.0506132204460.1667@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nicolas Pitre wrote:
> Wow...  Did I really offend you so much?

People have been edgy on these thread, so I read your response in
light of that.

> I pretty know who you are, in case you forgot that we know each other, 
> and your reading into my words that I somehow might have been suggesting 
> that you would do that work yourself is rather amusing.

Yes, I'd say we know each other quite well, hence my surprise at
the reading I made of your tone. I'm glad that you've read this
must amusement, we'll laugh it off next month at OLS :)

> Thing is that there is just no existing clash.  At least not yet.  The 
> whole thing is not ready for merging as Ingo said and therefore any 
> discussion on merging issues are rather premature at this point.

I know Ingo's clearly stated that he isn't asking for it to be
included at this point. This I don't deny. Ingo, however, is
not alone in working on this, as you noted yourself ...

> Exactly.  How often has it been said on this very list and elsewhere: 
> "show me the patch"?  In other words, there is no point discussing any 
> merging issues when the project leader himself says it is not ready and 
> has not posted any patch labeled as merge candidate.  I somehow trust 
> Ingo for posting patches when they are ready to be reviewed for 
> integration into mainline +_if_ and _when_ it is time.  Until then loads 
> of changes may happen in the PREEMPT_RT code randering any present 
> discussion on merging rather moot.

Ah, well then please read my proposals in light of the sub-topic
that's been floating around in those threads regarding PREEMPT_RT
and fusion being orthogonal and how they could be used together.

As for "show me the patch", posting patches to LKML is by
definition asking for some measure of feedback. You're correct
in stating that until a proposal is made for inclusion, things
may change. Nothing precludes making suggestions though ...

In any case, I hope the above has clarified a few things. In
the mean time, I'll get back to the load of unrelated stuff that
I need to work on here.

Cheers,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
