Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWF3GrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWF3GrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 02:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWF3GrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 02:47:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8720 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751209AbWF3GrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 02:47:01 -0400
Date: Fri, 30 Jun 2006 07:46:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Milan Svoboda <msvoboda@ra.rockwell.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Deepak Saxena <dsaxena@plexity.net>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
Message-ID: <20060630064652.GA17270@flint.arm.linux.org.uk>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>,
	Esben Nielsen <nielsen.esben@googlemail.com>,
	Milan Svoboda <msvoboda@ra.rockwell.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Deepak Saxena <dsaxena@plexity.net>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
References: <OF92240490.78BE8F01-ONC125719C.0037A4FD-C125719C.00389E07@ra.rockwell.com> <Pine.LNX.4.64.0606291334540.10401@localhost.localdomain> <Pine.LNX.4.58.0606290803190.25935@gandalf.stny.rr.com> <20060629122541.GB9709@flint.arm.linux.org.uk> <Pine.LNX.4.58.0606290846170.28104@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0606290846170.28104@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 08:49:04AM -0400, Steven Rostedt wrote:
> Hi Russell,
> 
> Thanks for replying!

Please fix your email - I'm getting nothing but the following from
your mail servers:

2006-06-30 02:41:14 1FvwcO-0005b6-Rr == rostedt@goodmis.org R=dnslookup
 T=verp_smtp defer (-44): SMTP error from remote mail server after
 RCPT TO:<rostedt@goodmis.org>: host inbound.goodmis.org.emailmx.com
 [216.40.36.30]: 472 Validating Sender

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
