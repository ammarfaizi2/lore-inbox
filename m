Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUGVWXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUGVWXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 18:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUGVWXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 18:23:13 -0400
Received: from mail.tmr.com ([216.238.38.203]:39186 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S267313AbUGVWXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 18:23:04 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: A users thoughts on the new dev. model
Date: Thu, 22 Jul 2004 18:25:46 -0400
Organization: TMR Associates, Inc
Message-ID: <cdpee5$otu$1@gatekeeper.tmr.com>
References: <40FFD760.8060504@unix.eng.ua.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090534661 25534 192.168.12.100 (22 Jul 2004 22:17:41 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <40FFD760.8060504@unix.eng.ua.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evan Hisey wrote:
> To the Dev list:
>    First, thanks for all the work on the kernel. I try to keep up with 
> the list via both KernelTrap and  Kerneltraffic. Today I just saw the 
> discussion on the new development model.  As an end use of the vanilla 
> tree, I would like to point out that a large number of people and 
> projects rely on the vanilla kernel to be the stable tree do to the 
> overly varied and random patching nature of vendor supplied kernels 
> making them hard to call reliable. In the case of my preferred distro 
> Slackware,  the distro itself expects the vanilla tree to be stable and 
> reliable enough to not need any patches.  I believe this is the case for 
> a large number off distro' s and end users. Thank you for your time. 
> Please send any flames,comments, or complaints via CC, as I am not 
> sucribed to the list.

I confess I feel that this new model is a return to the bad old days 
when the stable tree wasn't. Sounds as if Andrew is bored with the idea 
of letting 2.7 be the development tree and just being the gatekeeper of 
STABLE new features for 2.6. Perhaps 2.7 should be opened and Andrew 
will have a place to play, and features can drift to 2.6 more slowly.

I agree that vendor kernels often have unexpected behaviour, 
"improvements" on the API, etc. They sometimes protect the user from 
himself, so that code which works fine on a vendor kernel fails 
miserably on a mainline kernel.

I'm sure developers will do whatever they please, but I think a 
development kernel would be nice about now, so people could try new 
things without restriction, and people who like to use a stable kernel 
could have one.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
