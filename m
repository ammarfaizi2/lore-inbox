Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292235AbSBOWke>; Fri, 15 Feb 2002 17:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292240AbSBOWjd>; Fri, 15 Feb 2002 17:39:33 -0500
Received: from bitmover.com ([192.132.92.2]:5775 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292243AbSBOWiH>;
	Fri, 15 Feb 2002 17:38:07 -0500
Date: Fri, 15 Feb 2002 14:38:07 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>, Dave Jones <davej@suse.de>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215143807.L28735@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Richard Gooch <rgooch@ras.ucalgary.ca>, Dave Jones <davej@suse.de>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com> <20020215221532.K27880@suse.de> <20020215155817.A14083@thyrsus.com> <200202152209.g1FM9PZ00855@vindaloo.ras.ucalgary.ca> <20020215165029.C14418@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020215165029.C14418@thyrsus.com>; from esr@thyrsus.com on Fri, Feb 15, 2002 at 04:50:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 04:50:29PM -0500, Eric S. Raymond wrote:
> Richard Gooch <rgooch@ras.ucalgary.ca>:
> > Repeat after me: Linus is a bastard. Linus doesn't care.
> 
> Fine.  We all know Linus is a bastard. 
> 
> If that's so, then why are the likes of Jeff Garzik and Al Viro 
> spending so much effort trying to make *me* into the bad guy?

Perhaps they don't like the results of your efforts and they resent what
they perceive to be end runs around the normal process of getting changes
accepted.  As well they should.  Your attempt to avoid peer review is 
disgusting, it's the worst of what happens in closed source shops when
marketing forces the wrong answer in over the objections of the people
who have to live with it.  Yuck.

If you really want to contribute, what you'll do is improve the existing
system.  Screaming that it can't be done just means you aren't a kernel
programmer.  What kernel programmers do is the hard ugly work it takes to
make things work smoothly.  Look at any device driver - just a handfull
of simple interfaces: open,close,read,write,ioctl (ok that last one is
far from simple).  Now go look at the code implementing those interfaces,
it's frequently a huge effort to make some recalcitrant device behave.

But that's what kernel programmers do.  They take a mess and present
a clean, well working system.  No one said it was easy.  If you are a
kernel programmer, you can take CML1 and make it work, for a reasonable
definition of "work".  If you can't, you're far better off to admit
you're in over your head and give it up.  Harping on CML2 as the better
answer isn't going to work.  Neither is telling people they don't get it,
when those same people have done 10,000 times more work on the kernel
than you'll ever do.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
