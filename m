Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310463AbSCBVex>; Sat, 2 Mar 2002 16:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310462AbSCBVeo>; Sat, 2 Mar 2002 16:34:44 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:43413 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S310461AbSCBVe2>;
	Sat, 2 Mar 2002 16:34:28 -0500
Date: Sat, 2 Mar 2002 16:34:27 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: dell inspiron and 2.4.18?
In-Reply-To: <Pine.SGI.4.31L.02.0203020004440.5865235-100000@irix2.gl.umbc.edu>
Message-ID: <Pine.SGI.4.31L.02.0203021630440.5635100-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2002, John Jasen wrote:

> I have a Dell Inspiron 3700 running Redhat 7.2 with the latest updates,
> and I just upgraded to kernel 2.4.18. On random intervals, usually within
> about 10 minutes of usage, it hangs completely solid.
>
> Enabling sysrq, recompiling 2.4.18 with kdb, and going to tinker with APIC
> tomorrow. Results, kernel .config, lspci -v, and so forth will be posted
> when I'm more awake.
>
> Anyway, the short form: anyone else have any problems, or have I gone
> crazy again?

kernel config, dmesg output, lspci -vv output, /proc/interrupts and
/proc/pci have been posted to http://www.realityfailure.org/~jjasen/dell/

this is for kernel-2.4.18, with kdb patched and enabled, sysrq enabled,
and I'm sitting here waiting for it to go wrong.

And waiting!

uptime
  4:28pm  up 13 min,  6 users,  load average: 0.05, 0.44, 0.35

Any ideas?

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

