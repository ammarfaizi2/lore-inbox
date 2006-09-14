Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWINUmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWINUmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWINUmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:42:08 -0400
Received: from aa004msr.fastwebnet.it ([85.18.95.67]:25992 "EHLO
	aa004msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751158AbWINUmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:42:05 -0400
Date: Thu, 14 Sep 2006 22:35:39 +0200
From: Mattia Dongili <malattia@linux.it>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
Message-ID: <20060914203539.GD3963@inferi.kami.home>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	USB development list <linux-usb-devel@lists.sourceforge.net>
References: <20060914201919.GB3963@inferi.kami.home> <Pine.LNX.4.44L0.0609141622030.6982-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0609141622030.6982-100000@iolanthe.rowland.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc5-mm1-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 04:25:26PM -0400, Alan Stern wrote:
> On Thu, 14 Sep 2006, Mattia Dongili wrote:
[...]
> > Will try again with USB_SUSPEND=y, tomorrow I'll try to find some time
> > to test all the other things you suggested  (if still necessary) :)
> 
> No, don't do that.  Keep USB_SUSPEND=n, and try only the most recent patch

damn! (hitting ctrl-c) :)

> I sent to Rafael:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=115825076000987&w=2
> 
> I know for certain that some of Rafael's problems are different from 
> yours, because his involve ehci-hcd and ohci-hcd whereas you have only 
> UHCI controllers.

ok, will do. But please allow some time (can go back to you tomorrow) as
I'm in low-spare-time-mode...

-- 
mattia
:wq!
