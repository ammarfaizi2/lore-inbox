Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264064AbTIBUcx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbTIBUcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:32:52 -0400
Received: from smtphost.cis.strath.ac.uk ([130.159.196.96]:40381 "EHLO
	smtphost.cis.strath.ac.uk") by vger.kernel.org with ESMTP
	id S264099AbTIBUa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:30:58 -0400
Date: Tue, 2 Sep 2003 21:30:43 +0100
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Same problem with pcmcia in 2.4.22 as in 2.6.0-test4
Message-ID: <20030902203043.GA12997@iain-vaio-fx405>
Mail-Followup-To: kernel <linux-kernel@vger.kernel.org>
References: <1061936739.10642.6.camel@garaged.fis.unam.mx> <20030826223405.GA2746@iain-vaio-fx405> <20030831121019.GB22771@iain-vaio-fx405> <20030831133846.C3017@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831133846.C3017@flint.arm.linux.org.uk>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.6.0-test3 (i686)
X-Uptime: 21:28:59 up  5:15,  3 users,  load average: 0.03, 0.06, 0.07
X-Message-Flag: Outlook viruses can be made to send private documents from your hard drive to any or all recipients from your address book. But it only happens about once a month or so, so it's okay. Just keep on using it.
User-Agent: Mutt/1.5.4i
X-CIS-MailScanner: Found to be clean
X-CIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.8, required 5,
	BAYES_00 -5.20, IN_REP_TO -0.37, QUOTED_EMAIL_TEXT -0.38,
	REFERENCES -0.00, REPLY_WITH_QUOTES 0.00, USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King (rmk@arm.linux.org.uk) wrote:
> On Sun, Aug 31, 2003 at 01:10:20PM +0100, iain d broadfoot wrote:
> > Hallo again,
> > 
> > Just wondering if anyone has any insights into what's going wrong with
> > my pcmcia in both 2.4.22 and 2.6.0-test4.
> > 
> > orinoco_cs: RequestIRQ: Resource in use
> > 
> > is the error I get on inserting my wireless card.
> 
> There's a patch on pcmcia.arm.linux.org.uk for 2.6.0-test4 which gets
> some more information about what went wrong.  Could you apply it and
> report the kernel messages please?

the output the patch should've sent didn't show up in dmesg at all...

I had the same error message as before.

does that indicate anything helpful?

cheers,

iain

-- 
"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -- St. Augustine

"As for compromises: no. Free or fuck off." -- Andrew Suffield, on debian-legal
