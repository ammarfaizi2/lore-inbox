Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313715AbSDUSUV>; Sun, 21 Apr 2002 14:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313666AbSDUSSt>; Sun, 21 Apr 2002 14:18:49 -0400
Received: from bitmover.com ([192.132.92.2]:41115 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313720AbSDUSSe>;
	Sun, 21 Apr 2002 14:18:34 -0400
Date: Sun, 21 Apr 2002 11:18:32 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: CaT <cat@zip.com.au>, Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421111832.Q10525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <garzik@havoc.gtf.org>, CaT <cat@zip.com.au>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yfW9-0000aZ-00@starship> <20020421171629.GK4640@zip.com.au> <20020421104046.J10525@work.bitmover.com> <20020421134851.B7828@havoc.gtf.org> <20020421105437.L10525@work.bitmover.com> <20020421135955.B8142@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 01:59:55PM -0400, Jeff Garzik wrote:
> On Sun, Apr 21, 2002 at 10:54:37AM -0700, Larry McVoy wrote:
> > On Sun, Apr 21, 2002 at 01:48:51PM -0400, Jeff Garzik wrote:
> > > Can you get the bkbits.net interface to spit out text/plain GNU-style
> > > patches?
> > 
> > Not on bkbits.net.  It eats up too much bandwidth.
> 
> Your bkbits.net web interface _already_ spits out HTML-ized patches.
> It _reduces_ bandwidth to spit them out as text/plain.

I know it does and people use it to casually browse the tree, not as an
update mechanism.  What you are talking about is something which makes
BK a GNU patch server.  A useful thing, I can imagine, but it isn't
happening on bkbits.net unless someone offers to pick up the cost of
another T1 line.  $800/month.

As it is we share the T1 line that bkbits.net uses with everything else,
including our voice over IP phone system.  I can definitely tell when 
someone does something on bkbits, it tends to garble the phone.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
