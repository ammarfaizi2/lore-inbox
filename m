Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311552AbSCTEir>; Tue, 19 Mar 2002 23:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311554AbSCTEih>; Tue, 19 Mar 2002 23:38:37 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32012 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311552AbSCTEiZ>; Tue, 19 Mar 2002 23:38:25 -0500
Date: Tue, 19 Mar 2002 23:36:24 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Ken Brownfield <ken@irridia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: I/O APIC fixed in 2.4.19-pre3 & 2.5.6 (was Re: Linux 2.4.19-pre3)
In-Reply-To: <20020319183420.A15811@asooo.flowerfire.com>
Message-ID: <Pine.LNX.3.96.1020319233440.4610C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Ken Brownfield wrote:

> If noapic doesn't fix your problem, the I/O APIC patch won't help
> unfortunately, AFAIK.  Are these solid system-wide lockups not
> attributable to a binary-only X driver? ;)

Well, I used the Redhat compile of Xfree, but unless someone has a reason
to think that building from source will be in any way better I am not
about to do that, it's kind of major in terms of time and size.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

