Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWE0QZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWE0QZL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 12:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWE0QZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 12:25:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42247 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964879AbWE0QYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 12:24:45 -0400
Date: Fri, 26 May 2006 17:40:54 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Antonio <tritemio@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [radeonfb]: unclean backward scrolling
Message-ID: <20060526174054.GA3361@ucw.cz>
References: <5486cca80605210638l2906112fv515df1bc390cff24@mail.gmail.com> <447356BF.2080000@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447356BF.2080000@rainbow-software.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I'm using the radeonfb driver with a radeon 7000 with 
> >the frambuffer
> >at 1280x1024 on a i386 system, with a 2.6.16.17 kernel. 
> >At boot time,
> >if I stop the messages with CTRL+s and try look the 
> >previous messages
> >with CTRL+PagUp (backward scrolling) the screen become 
> >unreadable. In
> >fact some lengthier lines are not erased scrolling 
> >backward and some
> >random characters a overwritten instead. So it's very 
> >difficult to
> >read the messages.
> >
> >I don't have such problem with the frambuffer at 
> >1024x768.
> >
> >All the previous kernels I've tried have this problem 
> >(at least up to 2.6.15).
> >
> >If someone can look at this issue I can provide further 
> >information.
> 
> I have probably the same problem - but with vesafb on my 
> notebook (800x600). When I scroll back/forward or run mc 
> and then exit, it fixes itself. The problem was probably 
> always there (in 2.6.x - don't know about older 
> versions).

I see it too, and it is as old as framebuffer support iirc.

-- 
Thanks for all the (sleeping) penguins.
