Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVFVRZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVFVRZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVFVRX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:23:26 -0400
Received: from opersys.com ([64.40.108.71]:53005 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261830AbVFVRVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:21:21 -0400
Message-ID: <42B9A0A5.6000703@opersys.com>
Date: Wed, 22 Jun 2005 13:32:21 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: paulmck@us.ibm.com, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost>	 <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com>	 <20050622011931.GF1324@us.ibm.com>  <42B9845B.8030404@opersys.com> <1119460661.491.31.camel@mindpipe>
In-Reply-To: <1119460661.491.31.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lee Revell wrote:
> Ingo, what's the status of putting irq 0 back in a thread with
> PREEMPT_RT?  IIRC this had some adverse (maybe unfixable?) effects so it
> was disabled a few months ago.
> 
> I don't think there's much point in comparing i-pipe to PREEMPT_RT if we
> know that 21usec pipeline effect from the timer IRQ (see list archives)
> is still there.

A link to the archives somewhere would be greatly appreciated, this is
a very high traffic list after all...

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
