Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268110AbRHCJ4D>; Fri, 3 Aug 2001 05:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267615AbRHCJzx>; Fri, 3 Aug 2001 05:55:53 -0400
Received: from cdt1.tz-juelich.de ([195.37.52.66]:61056 "HELO
	feivel.credativ.de") by vger.kernel.org with SMTP
	id <S267579AbRHCJzs>; Fri, 3 Aug 2001 05:55:48 -0400
Date: Fri, 3 Aug 2001 11:58:07 +0200
To: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        linux-smp@vger.kernel.org, debian-user@lists.debian.org
Subject: Problem with customer machine
Message-ID: <20010803115807.A12739@feivel.credativ.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: Michael.Meskes@credativ.de (Michael Meskes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we are setting up a customer machine and experience the following messages
over and over again:

Aug  2 17:09:40 MDVTS054 kernel: unexpected IRQ vector 221 on CPU#0!
Aug  2 17:10:45 MDVTS054 kernel: unexpected IRQ vector 216 on CPU#0!

Now I found a lot of mail in some list archives about the same messages or
at least similar with a different number. But I did not find any reply to
these messages. AFAICT this means the IRQ handler notices an IRQ it does not
know how to handle. Is that correct?

The machine appears to run stable but the message comes up about once per
minute. If it does not do any harm I'm willing to just removed the message,
but before I like to know exactly what's that all about. In particular I
need to find out if this results from a hardware problem.

Does anyone know or has a link for me to read about this?

BTW there is another problem. The machine hangs solid during reboot after
printing "disabeling symmetric io mode".

The machine is a dual Xeon with gdt7629 controller.

Thanks for any hints.

Michael

P.S.: Please CC me on replies since I am not subscribed here.
-- 
Michael Meskes
Michael@Fam-Meskes.De
Go SF 49ers! Go Rhein Fire!
Use Debian GNU/Linux! Use PostgreSQL!
