Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277494AbRJEQ4e>; Fri, 5 Oct 2001 12:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277486AbRJEQ4Y>; Fri, 5 Oct 2001 12:56:24 -0400
Received: from [192.132.92.2] ([192.132.92.2]:56995 "EHLO
	bitmover.bitmover.com") by vger.kernel.org with ESMTP
	id <S277415AbRJEQ4K>; Fri, 5 Oct 2001 12:56:10 -0400
Date: Fri, 5 Oct 2001 09:56:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: rugolsky@ead.dsa.com
Cc: linux-kernel@vger.kernel.org, lm@bitmover.com, jgiglio@smythco.com
Subject: Re: 3ware discontinuing the Escalade Series
Message-ID: <20011005095639.H14219@work.bitmover.com>
Mail-Followup-To: rugolsky@ead.dsa.com, linux-kernel@vger.kernel.org,
	lm@bitmover.com, jgiglio@smythco.com
In-Reply-To: <20011004141942.A28202@lenina.bedford.smythco.com> <20011005090940.B26141@work.bitmover.com> <20011005125259.B1221@ead45>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011005125259.B1221@ead45>; from rugolsky@ead.dsa.com on Fri, Oct 05, 2001 at 12:52:59PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 12:52:59PM -0400, rugolsky@ead.dsa.com wrote:
> On Fri, Oct 05, 2001 at 09:09:40AM -0700, Larry McVoy wrote:
> > On Thu, Oct 04, 2001 at 02:19:42PM -0400, Jason Giglio wrote:
> > > 3ware has decided to discontinue their escalade series IDE RAID controller
> > > cards.  The drivers were open source and in the kernel tree.
> > 
> > OK, this sucks because I like those cards a lot.  Before I go out and
> > stock up on a bunch of them, is there anything else out there that works
> > as well and is supported by Linux?
> 
> Not that I know of; the other cards just don't seem to scale as well.
> What a shame.

I personally don't use teh 3ware raid features at all, I use the card
as a high performance interface to 4 drives and do my own backups
(I mirror each disk to /nightly, /weekly, and /monthly which is kind
of neat because you can do "$ diff foo.c /nightly/$PWD" and it works,
saves a lot of headaches).

Are there decent alternatives if all you want is a high performance
JBOD controller?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
