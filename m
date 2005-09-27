Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbVI0WPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbVI0WPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbVI0WPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:15:05 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:60339
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S965213AbVI0WPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:15:04 -0400
Subject: Re: 2.6.14-rc2-rt2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com, emann@mrv.com,
       yang.yi@bmrtech.com
In-Reply-To: <1127840377.27319.11.camel@cmn3.stanford.edu>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>
	 <1127840377.27319.11.camel@cmn3.stanford.edu>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 28 Sep 2005 00:15:39 +0200
Message-Id: <1127859339.15115.208.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 09:59 -0700, Fernando Lopez-Lezcano wrote:
> {standard input}:165: Error: can't resolve `.sched.text' {.sched.text
> section} - `.Ltext0' {.text section}
> make[1]: *** [arch/i386/kernel/semaphore.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [arch/i386/kernel] Error 2
> make: *** Waiting for unfinished jobs....

Thats a gcc problem. Which gcc version are you using ?

tglx


