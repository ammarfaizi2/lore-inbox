Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264798AbUE2NUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbUE2NUK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUE2NUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:20:10 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:28036 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264798AbUE2NT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:19:59 -0400
Date: Sat, 29 May 2004 15:20:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Larry McVoy <lm@work.bitmover.com>, bitkeeper-announce@work.bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: bk-3.2.0 released
Message-ID: <20040529132018.GA6221@ucw.cz>
References: <20040518233238.GC28206@work.bitmover.com> <20040529095419.GB1269@ucw.cz> <20040529130436.GA20605@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529130436.GA20605@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 06:04:36AM -0700, Larry McVoy wrote:
> On Sat, May 29, 2004 at 11:54:20AM +0200, Vojtech Pavlik wrote:
> > On Tue, May 18, 2004 at 04:32:38PM -0700, Larry McVoy wrote:
> > > BitKeeper Users,
> > > 
> > > BK/Pro 3.2.0 has been released and is in the BK download area,
> > > 
> > >     http://bitmover.com/download
> > 
> > Any chance of a native x86-64 version? 
> 
> We don't have any x86-64 machines but we could get one.  I asked about this
> a while back and people told me that there was no point, the x86 one worked
> perfectly.  Can you tell me what having a native one would gain?  If there
> is any gain we'll do it.

Well, yes, of course, the x86 version works just fine, because x86-64 is
backward compatible.

The benefits won't be huge:

	a marginal speed increase due to more registers
	no need for 32-bit libs on the system and in memory
	enough address space for bk, should it ever need more
	a general feeling of doing things right ;)	

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
