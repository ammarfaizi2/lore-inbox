Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVBUETu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVBUETu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 23:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVBUETt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 23:19:49 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:53245 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261158AbVBUETs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 23:19:48 -0500
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
	interrupts. Fish. Please report.]
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
In-Reply-To: <Pine.LNX.4.58.0502200954350.2378@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
	 <1108863372.8413.158.camel@localhost.localdomain>
	 <20050220082226.A7093@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0502200905060.2378@ppc970.osdl.org>
	 <Pine.LNX.4.58.0502200954350.2378@ppc970.osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 20 Feb 2005 23:19:31 -0500
Message-Id: <1108959571.8413.179.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-20 at 09:56 -0800, Linus Torvalds wrote:

> Steven, does this fix it without the need for any kernel command line (or
> any other patches, for that matter - ie revert all the transparency-
> changing ones)?
> 
> 		Linus
> 

Hi Linus,

I just tried it out (after removing all my crap) and yes it works.  

Thanks,

-- Steve


