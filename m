Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965234AbVI0XLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbVI0XLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbVI0XLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:11:41 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:61376 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S965234AbVI0XLk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:11:40 -0400
Subject: Re: 2.6.14-rc2-rt2
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com, emann@mrv.com,
       yang.yi@bmrtech.com
In-Reply-To: <1127859339.15115.208.camel@tglx.tec.linutronix.de>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>
	 <1127840377.27319.11.camel@cmn3.stanford.edu>
	 <1127859339.15115.208.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 16:11:01 -0700
Message-Id: <1127862661.4682.28.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 00:15 +0200, Thomas Gleixner wrote:
> On Tue, 2005-09-27 at 09:59 -0700, Fernando Lopez-Lezcano wrote:
> > {standard input}:165: Error: can't resolve `.sched.text' {.sched.text
> > section} - `.Ltext0' {.text section}
> > make[1]: *** [arch/i386/kernel/semaphore.o] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [arch/i386/kernel] Error 2
> > make: *** Waiting for unfinished jobs....
> 
> Thats a gcc problem. Which gcc version are you using ?

# gcc --version
gcc (GCC) 4.0.1 20050727 (Red Hat 4.0.1-5)
(on FC4)

-- Fernando


