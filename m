Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266596AbUG0UTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266596AbUG0UTH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266590AbUG0UTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:19:07 -0400
Received: from mail.tmr.com ([216.238.38.203]:2572 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266596AbUG0URo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:17:44 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: A users thoughts on the new dev. model
Date: Tue, 27 Jul 2004 16:20:35 -0400
Organization: TMR Associates, Inc
Message-ID: <ce6cur$i2m$1@gatekeeper.tmr.com>
References: <40FFD760.8060504@unix.eng.ua.edu><40FFD760.8060504@unix.eng.ua.edu> <20040722155759.0299dbc7.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1090959132 18518 192.168.12.100 (27 Jul 2004 20:12:12 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <20040722155759.0299dbc7.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Evan,
> 
> Have you found (1) Linus' 2.6 bk tree to meet your needs over the last
> few months?  Or (2) has it been too unstable for you?
> 
> If (1), seems like you might be in good shape, as from what I can
> gather of this (not being in Ottawa) next month looks alot like
> last month, so far as how Linux is developed.
> 
> If (2), then perhaps there is an opportunity here for a derivative of
> Linus' tree that is "stabilized a bit", but not overly patched like
> certain vendor kernels I won't name.
> 
> Yes, we'd all like the head kernel to march to the beat of our
> particular needs, rapidly changing and adding what we need without
> delay, leaving the rest untouched, and never breaking.
> 
> Now ... back to reality ...
> 
I'm not sure that's true, I personally think there is a lot to be said 
about the model currently being used for 2.2 and 2.4, which is almost 
totally bug-fix mode. Is that bad? The addition of minor fixes, like 
better scheduling, should not impact stability, let more massive changes 
(and feature deletions) be omitted. Is a new Reiser version likely to be 
more stable than what we have, or should this wait for a development 
version? Good, put it somewhere else.

I like to invert the arguments for putting new stuff in 2.6, let's go 
back to the excitement of development and open 2.7, and put 2.6 out to 
pasture right away. Then 2.6 can really be stable and 2.7 can go hog 
wild, without holding back the developers with pesky users.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
