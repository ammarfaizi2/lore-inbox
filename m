Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261461AbSKBWB7>; Sat, 2 Nov 2002 17:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSKBWB7>; Sat, 2 Nov 2002 17:01:59 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:1739 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261461AbSKBWBg>;
	Sat, 2 Nov 2002 17:01:36 -0500
Date: Sat, 2 Nov 2002 23:08:07 +0100
From: bert hubert <ahu@ds9a.nl>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] total-epoll r2 ...
Message-ID: <20021102220807.GA9947@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021102213759.GA9440@outpost.ds9a.nl> <Pine.LNX.4.44.0211021409570.951-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211021409570.951-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 02:11:44PM -0800, Davide Libenzi wrote:

> > Am I correct in understanding that this is no longer true because epoll_ctl
> > inserts an event if the poll condition is met?
> 
> Yep, I forgot to edit that one ...

Cool - this makes epoll a really nice interface.

> > Furthermore, I don't think the epoll(2) page is that helpful as even an
> > application developer that follows lkml (ie, me) has any use of the
> > 'waitqueue' analogy.
> 
> Sigh, I liked Jamie explanation :)
> Ok, there's still some work to do on man pages ...

You could put this in epoll.4 perhaps.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
