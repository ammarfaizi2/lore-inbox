Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287283AbRL3AE6>; Sat, 29 Dec 2001 19:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287280AbRL3AEs>; Sat, 29 Dec 2001 19:04:48 -0500
Received: from bitmover.com ([192.132.92.2]:59048 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S287270AbRL3AEn>;
	Sat, 29 Dec 2001 19:04:43 -0500
Date: Sat, 29 Dec 2001 16:04:42 -0800
From: Larry McVoy <lm@bitmover.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
Message-ID: <20011229160442.E21760@work.bitmover.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Larry McVoy <lm@bitmover.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011229153518.B21760@work.bitmover.com> <Pine.LNX.4.43.0112291739140.18183-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.43.0112291739140.18183-100000@waste.org>; from oxymoron@waste.org on Sat, Dec 29, 2001 at 05:59:15PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 05:59:15PM -0600, Oliver Xymoron wrote:
> > > > Is it really true that there are any significant number of patches
> > > > submitted that don't even compile?
> > >
> > > No
> >
> > OK, so there are no significant numbers of patches that the patchbot will
> > eliminate, by your admission.
> 
> Except for the ones that get garbage collected after each new kernel
> release WHEN THE VALIDITY OF THE QUEUE IS RECHECKED.

Which is how many?  Do you have _any_ data which shows that this is going
to do anything?  Everything I know says that you're in the 1% area.  My
experience is perhaps different than yours, but I'd like to know why.

> > So what's the point?  What is the problem you have solved?  And where's
> > the code?  This sounds like you have whittled it down to a cgi-script of
> > about 100 lines of perl.  How about building it and demonstrating the
> > usefulness rather than telling us how great it is going to be?
> 
> The original suggestion (about the possibility of compile-testing patches
> incrementally) was dependent on kbuild and CML2 being in the kernel
> already, but I do have a proof-of-concept for the rest in the works.

Great, so set it up, write a parser that grabs all the patches out of the
list, run them through your system, and report back how much it helps.
I don't think it will but if it does and you are willing to do the work,
more power to you.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
