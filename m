Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVLWP1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVLWP1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 10:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVLWP1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 10:27:49 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:17305 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964995AbVLWP1s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 10:27:48 -0500
Message-ID: <43AC1791.1080806@tmr.com>
Date: Fri, 23 Dec 2005 10:28:17 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, axboe@suse.de,
       herbert@gondor.apana.org.au, michael.madore@gmail.com,
       david-b@pacbell.net, gregkh@suse.de, paulmck@us.ibm.com, gohai@gmx.net,
       luca.risolia@studio.unibo.it, p_christ@hol.gr
Subject: Re: 2.6.15-rc6: known regressions in the kernel Bugzilla
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>	<20051222011320.GL3917@stusta.de>	<20051222005209.0b1b25ca.akpm@osdl.org>	<20051222135718.GA27525@stusta.de> <20051222060827.dcd8cec1.akpm@osdl.org>
In-Reply-To: <20051222060827.dcd8cec1.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> 
>>not a post-2.6.14 regression
>>
> 
> 
> Well yeah.  But that doesn't mean thse things have lower priority that
> post-2.6.14 regressions.
> 
> I understand what you're doing here, but we should in general concentrate
> upon the most severe bugs rather than upon the most recent..

Hypocratic oath: "First, do no harm."

If a new kernel version can't make things *better*, at least it 
shouldn't make them *worse*. New features are good, performance 
improvements are good, breaking working systems with an update is not good.

I'm with Adrian on this, if you want people to test and report with -rc 
kernels, then there should be some urgency to addressing the reported 
problems.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
