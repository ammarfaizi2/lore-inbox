Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286672AbSAFBCU>; Sat, 5 Jan 2002 20:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286662AbSAFBCL>; Sat, 5 Jan 2002 20:02:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44435 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286650AbSAFBCG>;
	Sat, 5 Jan 2002 20:02:06 -0500
Date: Sun, 6 Jan 2002 03:59:25 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Stephen Clark <sclark46@verizon.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched-01-2.4.17-B0
In-Reply-To: <3C37878F.9090409@verizon.net>
Message-ID: <Pine.LNX.4.33.0201060358130.4284-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Stephen Clark wrote:

> System comes up ok, I log into KDE that works. I then try to start
> mozilla session, a few seconds later the screen goes black and the
> system reboots.
>
> Anything I can do to help trouble shoot?

one thing appears to be common - it happens in or after loading modules.
Could you perhaps try to compile a fully static kernel, with no module
support? Thanks,

	Ingo

