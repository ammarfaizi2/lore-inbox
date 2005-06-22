Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVFVTFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVFVTFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 15:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVFVTFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 15:05:44 -0400
Received: from opersys.com ([64.40.108.71]:3855 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261813AbVFVTFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 15:05:37 -0400
Message-ID: <42B9B917.9010606@opersys.com>
Date: Wed, 22 Jun 2005 15:16:39 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <42B9A6D6.4060109@opersys.com> <20050622184748.GF1296@us.ibm.com>
In-Reply-To: <20050622184748.GF1296@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney wrote:
> (And, yes, there are other CDFs lacking a 30us bulge that would be
> consistent with a 55us "blue-moon" bulge -- so I guess I am asking
> if you have the CDF or the raw latency measurements -- though the
> data set might be a bit large...  And I would have to think about
> how one goes about deriving individual-latency CDF(s) given a single
> dual-latency CDF, assuming that this is even possible...)

This is a bandwidth issue. The compressed archive containing the
interrupt latencies of all our test runs is 100MB. I could provide
a URL _privately_ to a handful of individuals, but beyond that
someone's going to have to host it.

Let me know if you want this.

Of course, now that LRTBF is out there, others can generate their
own data sets.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
