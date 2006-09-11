Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWIKHrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWIKHrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 03:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWIKHrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 03:47:53 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:39405 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1751195AbWIKHrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 03:47:52 -0400
Date: Mon, 11 Sep 2006 09:52:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Menuconfig won't draw lines on my terminal?
Message-ID: <20060911075240.GA20025@uranus.ravnborg.org>
References: <200609110152_MC3-1-CAD7-1E87@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609110152_MC3-1-CAD7-1E87@compuserve.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 01:51:26AM -0400, Chuck Ebbert wrote:
> Using PuTTY as SSH client, I get ASCII chars instead of lines when
> I use menuconfig:
> 
>  Linux Kernel v2.6.18-rc6 Configuration
>  qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq
>   lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq Linux Kernel Configuration qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk
>   x  Arrow keys navigate the menu.  <Enter> selects submenus --->.  Highlighted letters are     x
>   x  hotkeys.  Pressing <Y> includes, <N> excludes, <M> modularizes features.  Press <Esc><Esc> x
>   x  to exit, <?> for Help, </> for Search.  Legend: [*] built-in  [ ] excluded  <M> module     x
>   x  < > module capable                                                                         x
>   x lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk x
>   x x             Code maturity level options  --->                                           x x
>   x x             General setup  --->                                                         x x
>   x x             Loadable module support  --->                                               x x
> 
> 
> This happens on both Fedora Core 2 and 5.  Midnight Commander draws lines,
> so I know the characters are in the font.

I need to do a 'reset' before it works for me.
I never managed to understand why I need to reset my terminal. My
interest soft of disapperead when I got it working.

	Sam
