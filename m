Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312361AbSDSMHC>; Fri, 19 Apr 2002 08:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312392AbSDSMHB>; Fri, 19 Apr 2002 08:07:01 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:57866 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S312361AbSDSMHB>; Fri, 19 Apr 2002 08:07:01 -0400
Message-ID: <3CBFFC11.A851755A@compro.net>
Date: Fri, 19 Apr 2002 07:14:25 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <Pine.LNX.3.96.1020418115423.5375B-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> On Wed, 17 Apr 2002, James Bourne wrote:
> 
> > After Ingo forwarded me his original patch (I found his patch via a web
> > based medium, which had converted all of the left shifts to compares, and
> > now I'm very glad it didn't boot...) and the system is booted and is
> > balancing most of the interrupts at least.  Here's the current output
> > of /proc/interrupts
> 

Is there a version of this patch for 2.4.18? I also found the one on the web site wouldn't
boot but would very much like to have a copy that would work for 2.4.18. Where might I find
this?

Ragards
Mark
