Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTK2JzD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 04:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTK2JzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 04:55:03 -0500
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:59839
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S261492AbTK2JzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 04:55:00 -0500
Date: Sat, 29 Nov 2003 01:57:12 -0800
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM Suspend Problem
Message-ID: <20031129095712.GA1814@nasledov.com>
References: <20031127062057.GA31974@nasledov.com> <20031129021712.GA13798@nasledov.com> <20031129022005.GE8039@holomorphy.com> <200311282238.21420.shawn-lkml@willden.org> <20031129054635.GG8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031129054635.GG8039@holomorphy.com>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My laptop suspends just fine now even with PCMCIA cards plugged in, as long
as the power cord is not plugged in as well .. It's great to finally be able
to use 2.6 on my laptop once again!

On Fri, Nov 28, 2003 at 09:46:35PM -0800, William Lee Irwin III wrote:
> On Friday 28 November 2003 07:20 pm, William Lee Irwin III wrote:
> >> There is an oddity I forgot to report: it doesn't suspend when I close
> >> the lid if I still have the power plugged in. Also, I tried the suspend
> >> button, and it works perfectly fine here for both suspend and resume on
> >> a standard LTC issue Stinkpad T21, again with the power cord proviso.
> 
> On Fri, Nov 28, 2003 at 10:38:18PM -0700, Shawn Willden wrote:
> > Do you also have a PCMCIA card in the slot?
> > I've always found that my Thinkpads (about three different models, 
> > currently a T21) will not suspend with power connected and a PCMCIA card 
> > in.  If I remove either power or my PC cards, then closing the lids will 
> > trigger a suspend.
> > I stumbled across something a while back that indicated this was a Thinkpad 
> > BIOS bug, but I have no idea if that is correct.
> 
> No, I rarely have PCMCIA cards in. Just the power cord being plugged in
> is enough to break it here.

-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
