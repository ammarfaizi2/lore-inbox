Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbUJZB7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbUJZB7c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUJZB5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:57:38 -0400
Received: from relay00.pair.com ([209.68.1.20]:32017 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261997AbUJZB1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:27:33 -0400
X-pair-Authenticated: 68.42.66.6
Subject: Re: The naming wars continue...
From: Daniel Gryniewicz <dang@fprintf.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <417D73C8.5040204@tmr.com>
References: <1098485798.6028.83.camel@gaston>
	 <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
	 <1098566710.3872.149.camel@baythorne.infradead.org>
	 <417D73C8.5040204@tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Oct 2004 21:27:30 -0400
Message-Id: <1098754050.19465.3.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-25 at 17:44 -0400, Bill Davidsen wrote:
> David Woodhouse wrote:
> 
> > Damn right. If 2.6.10 doesn't boot on the G5 with i8042 and 8250 drivers
> > built in, and doesn't sleep (well, more to the point doesn't resume) on
> > my shinybook, I shall sulk :)
> 
> Suspend is Shakespearean, "to sleep, perchance to dream." I don't know 
> why people are still trying the fix suspend, it works perfectly on all 
> my machines, I would like to see some work on wake-the-@-up at this point.
> 
> The sad part is that using apm and 2.4, all my laptops seem happy to 
> sleep and wake when asked. One of the reasons I'm running 2.4 on the old 
> ones, the new ones boot fast enought that I don't care.
> 

Well, for me, 2.6.9 *broke* wake up.  Suspend still works fine, but I'm
back to 2.6.9-rc4 to get working wake up.

Daniel
