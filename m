Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWEJT2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWEJT2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 15:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWEJT2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 15:28:24 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:25280 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751169AbWEJT2X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 15:28:23 -0400
Message-ID: <44623ED4.1030103@compro.net>
Date: Wed, 10 May 2006 15:28:20 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net> <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101446090.22959@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605101446090.22959@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Wed, 10 May 2006, Mark Hounschell wrote:
> 
>> Steven Rostedt wrote:
>>> Wow! I asked for some info on your system, and boy, did I get info! :)
>>>
>> Sorry. I talk to much.
> 
> No, by all means, I liked it.
> 
>>>> I can only say for sure that I do not have these "stops" when running
>>>> any other kernel or when running the rt20 kernel in any of the
>>>> non-complete preemption modes.
>>>>
>> Configured for "Preempable Kernel" I got the following but no "stops"
>> came with it.
> 
> Hmm, do you have "Compile kernel with frame pointers" turned on. It's in
> kernel hacking. It usually gives a better stack trace.
> 

I'll turn frame pointers on on this machine and do it again and then
also send you (off list) the logdev stuff you asked for from another
machine that is configured complete-preempt.

Mark

