Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265229AbUFRPfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUFRPfP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUFRPdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:33:51 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:10000 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265276AbUFRPZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:25:12 -0400
Message-ID: <40D30D7B.4060907@techsource.com>
Date: Fri, 18 Jun 2004 11:42:51 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: 4Front Technologies <dev@opensound.com>
CC: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk> <40D23EBD.50600@opensound.com>
In-Reply-To: <40D23EBD.50600@opensound.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



4Front Technologies wrote:

> That's right Al, 4Front, ATI, Nvidia are all evil!. OK so now get on 
> with life.
> 
> It's time everybody started to pay some attention to in-kernel 
> interfaces because
> Linux has graduated out of your personal sandbox to where other people 
> want to use
> Linux and they aren't kernel developers.
> 
> Sure we can fix the problem with SuSE - we've been doing this for the 
> past 7 years.
> And we know a thing or two about Linux kernels but wouldn't it be better 
> for the
> Linux community in general to have such source issue stabilized?


Stop whining.

People often complain about Linux lacking a stable kernel driver ABI. 
They act like it's some kind of conspiracy.  The truth of the matter is, 
Linux designers prefer technical flexibility over stable internal 
interfaces.  This is part of Linux philosophy -- it's part of the what 
defines Linux -- and so if you use Linux, this is something you simply 
have to ACCEPT.

If you don't want to accept that, develop for some other OS.  No one's 
begging you to develop commercial products for Linux.

Another important thing to note that whiners like yourself seem to miss 
is that kernel interfaces aren't really any more table in other 
operating systems.  Have you ever developed kernel drivers for different 
versions of Solaris?  Windows?  HPUX?  Tru64?  AIX?  OpenVMS?  Where I 
work, we develop drivers for all of those platforms, and every version 
of every one of those kernels is different from every other version that 
requires us to rewrite and recompile our drivers for each one separately.

So the fact that Linux doesn't have a stable driver ABI is actually one 
of its most mundane and commonplace attributes.

