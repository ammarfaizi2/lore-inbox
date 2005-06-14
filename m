Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVFNB5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVFNB5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 21:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVFNB5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 21:57:50 -0400
Received: from opersys.com ([64.40.108.71]:11024 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261342AbVFNB5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 21:57:46 -0400
Message-ID: <42AE3BEB.2070309@opersys.com>
Date: Mon, 13 Jun 2005 22:07:39 -0400
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
References: <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com> <42ADE334.4030002@opersys.com> <1118693033.2725.21.camel@dhcp153.mvista.com> <42ADEC0E.4020907@opersys.com> <1118694495.2725.32.camel@dhcp153.mvista.com> <42AE01EA.10905@opersys.com> <42AE04AE.8070107@opersys.com> <20050613221810.GA820@nietzsche.lynx.com> <42AE0875.8010001@opersys.com> <20050613222909.GA880@nietzsche.lynx.com> <42AE0EF8.1090509@opersys.com> <Pine.LNX.4.63.0506132052590.1667@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.63.0506132052590.1667@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nicolas Pitre wrote:
> The best way to do this stuff has already been outlined by Ingo himself, 
> and as far as I know he's still the man leading the show.

Touchy we are I see. Sorry to disappoint you, but I'm not interested
in stealing anyone's show.  I've got my own workload thank you very
much.

>  And no one 
> objected to his strategy so far.

Objections have been voiced. Go back and read earlier postings.

> There is just no rush.  It doesn't have to be integrated ASAP, and 
> actually not before a while, and then certainly not in a disturbing way.  
> Lots of things have to be cleaned up in the patch, and even in the 
> current stock kernel for that matter, and Ingo even agreed to that.

Sorry, but go back and check who's asking for ASAP. Then go back a
few e-mails and read back what I said:
> So one can keep ignoring the reality of the existing clash here,
> but it may just be that backing off a little and thinking about it
> in less absolute integration terms would help.

Certainly you realize that "backing off" and "thinking" have little
to do with any sort of "rush".

> So any discussion about merging of PREEMPT_RT into mainline is simply 
> hand waving at this point.  Let it evolve and resume this discussion 
> when there is actually something being proposed for merging into 
> mainline.

So in your opinion, we should all put our brains on idle until someone
posts a patch containing the words "please apply"?

Understand that I've got no inclination to going into a flamewar.
I just made some rearrangement suggestion and all hell broke loose
with people retreating to their defense positions reiterating
POVs that had little to do with what I was suggesting.

You can disagree with what I'm saying, but please read the previous
posts for context and don't put words in my mouth that I haven't said.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
