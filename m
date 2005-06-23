Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVFWBMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVFWBMB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVFWBMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:12:00 -0400
Received: from opersys.com ([64.40.108.71]:34834 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261952AbVFWBLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:11:44 -0400
Message-ID: <42BA0ED4.80207@opersys.com>
Date: Wed, 22 Jun 2005 21:22:28 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Ingo Molnar <mingo@elte.hu>, Bill Huey <bhuey@lnxw.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com> <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com> <20050623000607.GB11486@elte.hu> <42BA069D.20208@opersys.com> <Pine.LNX.4.62.0506221753010.16773@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0506221753010.16773@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Lang wrote:
> I know that I have a large number of slow (<200MHz) pentiums that are just 
> sitting around at home and could be used for this, but I don't know if 
> they would be considered fast enough for any portions of this test (I have 
> a much smaller number of faster machines that could possibly be used)

I don't think that there should be any limitation on the type of
hardware being tested. In fact, I would think that having as
diverse a test hardware as possible would be a good thing.
Many of the embedded platforms are in fact not that far different
from those slow pentiums you have lying around.

My 0.02$,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
