Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752162AbWCOXcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbWCOXcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWCOXck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:32:40 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:64218 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1752165AbWCOXcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:32:32 -0500
From: Grant Coady <gcoady@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Willy Tarreau <willy@w.ods.org>, Arjan van de Ven <arjan@infradead.org>,
       j4K3xBl4sT3r <jakexblaster@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Which kernel is the best for a small linux system?
Date: Thu, 16 Mar 2006 10:32:19 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <f78h1292orlp3vnrm2qq9c040ech0eduhg@4ax.com>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com> <1142237867.3023.8.camel@laptopd505.fenrus.org> <opcb12964ic9im9ojmobduqvvu4pcpgppc@4ax.com> <1142273212.3023.35.camel@laptopd505.fenrus.org> <20060314062144.GC21493@w.ods.org> <kv2d12131e73fjkp0hufomj152un5tbsj1@4ax.com> <20060314222131.GB3166@flint.arm.linux.org.uk> <Pine.LNX.4.61.0603152347210.20859@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603152347210.20859@yvahk01.tjqt.qr>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2006 23:53:21 +0100 (MET), Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

>
>>> By stable I mean rate of change of codebase, patch volume per month,  
>>> 2.6 is orders of magnitude less stable than 2.4 by that simple measure.
>>
>>That is no measure of stability.
>>
>
>Ack! Let's pick one:
>
>Although the exact numbers of patches per time for a specific 
>software manufacturer - let's pick Microsoft as an example - is not known, 
>it is usually low (two for this *month* afaics), compared to what hits lkml 
>*each day*.
>
>Does that make their software more stable than Linux? I would have my 
>doubts about that.

Yeah but MSFT has been very stably broken for many years ;)

Anyway, what I'm trying to put forward is the notion that the high 
patch churn rate in l-k indicates a non-stable, experimental piece 
of work which may one day result in a stable kernel.  But at the 
moment I'll run 24/7 apps on a 2.4.latest box.

That some here choose to bend that point of view into an unintended 
meaning has nothing to do with the simple reality that, for what I 
use linux for, 2.6 is a such sluggish performing kernel that I soon 
revert to 2.4.latest on the one box that runs 24/7 here.

If you cannot accept that, fine, ridicule the testers feedback you 
do not want to hear.

Certainly provides little motivation for testers to provide any 
feedback does it not?  I've had two threads on sluggish terminal 
here performance without resolution.  2.6 feels sluggish, the test 
is simple and repeatable, your ridicule does not change that at all.


2.4.early was a dog of a kernel, I was often bouncing between Linus' 
and ac' branches back then depending on which was working in a 
particular week.  It got better, as will 2.6.  Maybe by 2.6.20+ ?

Grant.
