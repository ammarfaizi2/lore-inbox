Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWF3TAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWF3TAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933069AbWF3TAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:00:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43026 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S933056AbWF3TAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:00:42 -0400
Date: Fri, 30 Jun 2006 20:00:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       Milan Svoboda <msvoboda@ra.rockwell.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Deepak Saxena <dsaxena@plexity.net>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
Message-ID: <20060630190030.GB13429@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Esben Nielsen <nielsen.esben@googlemail.com>,
	Milan Svoboda <msvoboda@ra.rockwell.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Deepak Saxena <dsaxena@plexity.net>,
	Thomas Gleixner <tglx@linutronix.de>
References: <OF92240490.78BE8F01-ONC125719C.0037A4FD-C125719C.00389E07@ra.rockwell.com> <Pine.LNX.4.64.0606291334540.10401@localhost.localdomain> <Pine.LNX.4.58.0606290803190.25935@gandalf.stny.rr.com> <20060630185046.GB29566@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630185046.GB29566@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 08:50:46PM +0200, Ingo Molnar wrote:
> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Well, the following patch may not be the best but I don't see it being 
> > any worse than what is already there.  I don't have any arm platforms 
> > or even an arm compiler, so I haven't even tested this patch with a 
> > compile.  But it should be at least a temporary fix.
> 
> thanks - i've applied this to -rt, we'll drop it once we rebase to 
> 2.6.18-rc.

Why not apply the one already in mainline which _has_ been tested to
fix this issue!?!?!

Am I talking to myself here?  I've said this three times now, including
this message.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
