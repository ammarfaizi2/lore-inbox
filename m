Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbTLEBVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 20:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbTLEBVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 20:21:34 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:55988 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263537AbTLEBVc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 20:21:32 -0500
Date: Thu, 4 Dec 2003 17:21:24 -0800
From: Larry McVoy <lm@bitmover.com>
To: Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031205012124.GB15799@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Erik Andersen <andersen@codepoet.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com> <20031205010349.GA9745@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205010349.GA9745@codepoet.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 06:03:49PM -0700, Erik Andersen wrote:
> On Thu Dec 04, 2003 at 07:58:18PM -0500, Zwane Mwaikambo wrote:
> > What about software which utilises Linux specific kernel
> > services, such as say some cd writing software?
> 
> An ordinary program that uses normal system calls?
> 
> linux/COPYING says: This copyright does *not* cover user programs
> that use kernel services by normal system calls - this is merely
> considered normal use of the kernel, and does *not* fall under
> the heading of "derived work".

Yeah, and the GPL specificly invalidates that statement.  We're on thin
ice here.  Linus is making up the rules, which is cool (since I tend to
like his rules) but the reality is that the GPL doesn't allow you to 
extend the GPL.  It's the GPL or nothing.

Given the GPL rules you have to disregard Linus' rules that are extensions
and work off of standard law.  When you get there it becomes an issue of
boundaries and the law seems to clearly support Linus' point of view, he
didn't need to make that clarification, whether he did or not, that's what
is true in the eyes of the law.

But given that, neither Linus (nor any of you) get to say "well, that's fine
for userland but drivers are derived works".  

I've said this over and over and I'll say it again.  If you want the
protection of the law you have to live with the law's rules.  You DO
NOT get to say "user programs are a boundary across which the GPL does
not apply but drivers are a boundary across which the GPL does apply".
It doesn't, and can't, work that way.  Either userland is GPL and drivers
are GPL or neither are GPLed.  Take your pick.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
