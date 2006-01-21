Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWAUAFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWAUAFa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWAUAF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:05:29 -0500
Received: from free.wgops.com ([69.51.116.66]:56585 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1750824AbWAUAF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:05:29 -0500
Date: Fri, 20 Jan 2006 17:05:02 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <D0E00DB2198D1C78C97244A7@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <20060120235520.GC20148@flint.arm.linux.org.uk>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 <20060120155919.GA5873@stiffy.osknowledge.org>
 <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
 <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr>
 <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com>
 <20060120194331.GA8704@kroah.com>
 <1C4B548965AFD4F5918E838D@d216-220-25-20.dynip.modwest.com>
 <20060120231757.GB20148@flint.arm.linux.org.uk>
 <8ADF978F40BCF69BF8BEC36F@d216-220-25-20.dynip.modwest.com>
 <20060120235520.GC20148@flint.arm.linux.org.uk>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 11:55:20 PM +0000 Russell King 
<rmk+lkml@arm.linux.org.uk> wrote:

> On Fri, Jan 20, 2006 at 04:33:38PM -0700, Michael Loftis wrote:
>> As long as it isn't wash rinse repeat, but in development kernels it
>> tends  to be.  That's the pain point.  It's not one single huge problem,
>> it's the  constant stream of little ones that we try to avoid.
>
> So what you're basically saying is that we should make zero changes
> to the kernel, because any change (even a minor bug fix) may cause
> you to need to do some work.  Should we just increment the version
> number every 3 months then?
>
> Maybe we could do this _if_ folk would stop working on the kernel,
> wanting it to run on their latest creations.
>
> The fact is that in the ARM world, everyone wants a stable kernel
> which has support for all the features in the SoC de jour that
> they're using.  That previous sentence is self-contradictory - it's
> an impossible scenario.  You can't have a kernel which supports the
> latest features without progressive and continuous change.
>

That's not quite what I want/need.  I want a stable kernel in all respects, 
one that has bugfixes and minor changes, for every day use, for building or 
deploying embedded systems on.  Yes for people who've got the SoC du juour 
the model is better, but for us poor buggers who couldn't give a crud about 
the latest greatest SoC it's a pain.

I think we can just let this thread die because apparently I'm in the very 
unvocal minority that is hurt and this change is costing more than others.

Right now as it sits, you have to bleed, or you don't get anything.  I 
think some more middle ground can be found...I'm just not totally sure it's 
wanted now after this line of discussion.
