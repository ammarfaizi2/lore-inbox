Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291194AbSCDDlf>; Sun, 3 Mar 2002 22:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291214AbSCDDlZ>; Sun, 3 Mar 2002 22:41:25 -0500
Received: from mx3out.umbc.edu ([130.85.253.53]:52688 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S291194AbSCDDlS>;
	Sun, 3 Mar 2002 22:41:18 -0500
Date: Sun, 3 Mar 2002 22:41:17 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: dell inspiron and 2.4.18?
In-Reply-To: <Pine.SGI.4.31L.02.0203021630440.5635100-100000@irix2.gl.umbc.edu>
Message-ID: <Pine.SGI.4.31L.02.0203032237250.6004117-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2002, John Jasen wrote:

> On Sat, 2 Mar 2002, John Jasen wrote:
>
> > I have a Dell Inspiron 3700 running Redhat 7.2 with the latest updates,
> > and I just upgraded to kernel 2.4.18. On random intervals, usually within
> > about 10 minutes of usage, it hangs completely solid.
> >
> > Enabling sysrq, recompiling 2.4.18 with kdb, and going to tinker with APIC
> > tomorrow. Results, kernel .config, lspci -v, and so forth will be posted
> > when I'm more awake.
> >
> > Anyway, the short form: anyone else have any problems, or have I gone
> > crazy again?
>
> kernel config, dmesg output, lspci -vv output, /proc/interrupts and
> /proc/pci have been posted to http://www.realityfailure.org/~jjasen/dell/
>
> this is for kernel-2.4.18, with kdb patched and enabled, sysrq enabled,
> and I'm sitting here waiting for it to go wrong.
>
> And waiting!

I'm beginning to think that this was just the ghost in the machine
screwing with me, as I've beaten on 2.4.18-kdb for about two days and it
hasn't hung.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

