Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264447AbRFTA2i>; Tue, 19 Jun 2001 20:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264448AbRFTA22>; Tue, 19 Jun 2001 20:28:28 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:48213
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S264447AbRFTA2Q>; Tue, 19 Jun 2001 20:28:16 -0400
Date: Tue, 19 Jun 2001 17:28:14 -0700
From: Larry McVoy <lm@bitmover.com>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010619172814.D14119@work.bitmover.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <p05100319b75593a25b1e@[10.128.7.49]> <20010619171945.I6778@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010619171945.I6778@thune.mrc-home.com>; from dalgoda@ix.netcom.com on Tue, Jun 19, 2001 at 05:19:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 05:19:45PM -0700, Mike Castle wrote:
> On Tue, Jun 19, 2001 at 04:56:16PM -0700, Jonathan Lundell wrote:
> > But so what? That's $16 worth of DRAM (I just checked). Not so bad 
> > *if* threads are otherwise a great solution. I grant that one might 
> > have a pretty tough time making the case, but again, for the right 
> > application, say some app with a dedicated server, 73MB isn't the end 
> > of the world (though I suppose it was at the time...).
> 
> How much would 73MB of cache cost?  How much would it cost to get that much
> on the CPU?

Good question but I doubt we're going to get anywhere.  Anyone who thinks
that 73MB of RAM is an OK thing to waste on window system is probably a
died-in-the-wool Java programmer and could care less about performance,
system design, or any elegance whatsoever.

It pains me to believe that people like this exist but there they are.
What can you do?  As Confucius says "If I hold up three corners of a square
and the student does not hold up the fourth, I do not bother to go over
the point again".
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
