Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVFKWjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVFKWjz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 18:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVFKWjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 18:39:55 -0400
Received: from opersys.com ([64.40.108.71]:519 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261844AbVFKWjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 18:39:32 -0400
Message-ID: <42AB66D1.20205@opersys.com>
Date: Sat, 11 Jun 2005 18:33:53 -0400
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
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com> <20050611201422.GA1299@us.ibm.com>
In-Reply-To: <20050611201422.GA1299@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney wrote:
> My guess is that there will end up being more than one benchmark, given
> the large variety of RT apps out there, but who knows?

I don't doubt. We just wanted to get people's attention to such aspects.
We believe that the framework we've built is general enough that others
will find it simple to graft their own tests on top and otherwise extend
it to their needs.

In any case, having more serious benchmarks published will certainly do
no harm.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
