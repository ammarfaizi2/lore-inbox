Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVARAYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVARAYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 19:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVARAYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 19:24:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:41923 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261532AbVARAYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 19:24:18 -0500
Date: Mon, 17 Jan 2005 16:24:17 -0800
From: Chris Wright <chrisw@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wright <chrisw@osdl.org>, Florian Weimer <fw@deneb.enyo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: security contact draft2 (was Re: security contact draft)
Message-ID: <20050117162417.O24171@build.pdx.osdl.net>
References: <20050113125503.C469@build.pdx.osdl.net> <87mzvd9f9a.fsf@deneb.enyo.de> <20050113141229.G24171@build.pdx.osdl.net> <1105744352.9838.33.camel@localhost.localdomain> <20050114184359.D469@build.pdx.osdl.net> <1105761548.11128.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1105761548.11128.0.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Sat, Jan 15, 2005 at 04:00:20AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Sad, 2005-01-15 at 02:43, Chris Wright wrote:
> > Guess it's an open question.  Do you agree with these basics bits?
> > 
> >  - no guarantee
> >  - attempt to work with reporter
> >  - attempt to work with vendors
> >  - goal of timely release
> >  - retain final say
> >  - within immediate to few weeks
> >  
> > Hard to put real time on it.
> 
> Its emphasising "release date set by linux-security not reporter" rather
> than length - although length guidance is good.

Minor changes to capture this.

thanks,
-chris

 DRAFT

 Linux kernel developers take security very seriously.  As such, we'd
 like to know when a security bug is found so that it can be fixed and
 disclosed as quickly as possible.  Please report security bugs to the
 Linux kernel security team.

 1) Contact

 The Linux kernel security team can be contacted by email at
 $CONTACTADR.  This is a private list of security officers
 who will help verify the bug report and develop and release a fix.
 It is possible that the security team will bring in extra help from
 area maintainers to understand and fix the security vulnerability.

 It is preferred that mail sent to the security team is encrypted
 with $PUBKEY.

 As it is with any bug, the more information provided the easier it
 will be to diagnose and fix.  Please review the procedure outlined in
 REPORTING-BUGS if you are unclear about what information is helpful.
 Any exploit code is very helpful and will not be released without
 consent from the reporter unless it has already been made public.

 2) Disclosure

 The goal of the Linux kernel security team is to work with the
 bug submitter to bug resolution as well as disclosure.  We prefer
 to fully disclose the bug as soon as possible.  It is reasonable to
 delay disclosure when the bug or the fix is not yet fully understood,
 the solution is not well-tested or for vendor coordination.  However, we
 expect these delays to be short, measurable in days, not weeks or months.
 A disclosure date is negotiated by the security team working with the
 bug submitter as well as vendors.  However, the kernel security team
 holds the final say when setting a disclosure date.  The timeframe for
 disclosure is from immediate (esp. if it's already publically known)
 to a few weeks.  As a basic default policy, we expect report date to
 disclosure date to be on the order of 7 days.

 3) Non-disclosure agreements
 
 The Linux kernel security team is not a formal body and therefore unable
 to enter any non-disclosure agreements.

