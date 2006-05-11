Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751683AbWEKNCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbWEKNCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 09:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbWEKNCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 09:02:39 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:49111 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751682AbWEKNCi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 09:02:38 -0400
Message-ID: <446335EA.3000506@compro.net>
Date: Thu, 11 May 2006 09:02:34 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net> <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101446090.22959@gandalf.stny.rr.com> <44623ED4.1030103@compro.net> <44631F1B.8000100@compro.net> <Pine.LNX.4.58.0605110739520.5610@gandalf.stny.rr.com> <Pine.LNX.4.58.0605110805470.5610@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605110805470.5610@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Thu, 11 May 2006, Steven Rostedt wrote:
> 
>> On Thu, 11 May 2006, Mark Hounschell wrote:
>>
>>> Mark Hounschell wrote:
>>>
>>>  After this one my network connection into the emulation was broken
>>> BTW.
> 
> Crap! I read your email too quick and didn't notice this.
> 
> The patch I sent you would probably only fix the warning, and not the bug.
> 
> Don't do the patch yet.  Could your run it again, and after it does the
> bug, and you lose the network connection, could you do a sysrq-t to get
> the state of the tasks.  You need sysrq turned on in the config.
> 

I hate to sound stupid but when I alt-sysreq-t or sysreq-t nothing
happens??? I do have sysreq configured. CONFIG_MAGIC_SYSRQ=y

Mark

