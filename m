Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVFKWdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVFKWdl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 18:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVFKWdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 18:33:41 -0400
Received: from opersys.com ([64.40.108.71]:54534 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261684AbVFKWdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 18:33:38 -0400
Message-ID: <42AB656E.6000104@opersys.com>
Date: Sat, 11 Jun 2005 18:27:58 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com> <20050611070845.GA4609@elte.hu> <42AAF5CE.9080607@opersys.com> <20050611145240.GA10881@elte.hu> <42AB2209.9080006@opersys.com> <20050611181528.GA15019@elte.hu> <20050611183411.GA16503@elte.hu>
In-Reply-To: <20050611183411.GA16503@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> find below your .config adopted to the latest -RT patch 
> (2.6.12-rc6-RT-V0.7.48-11).

OK thanks, we'll try to use this as-is and also use an as-close-as-possible
version for the Adeos tests that we have something comparable.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
