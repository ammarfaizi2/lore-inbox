Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUARQCW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 11:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUARQCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 11:02:22 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:15851 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261885AbUARQCT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 11:02:19 -0500
Date: Sun, 18 Jan 2004 08:02:17 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: bkbits going down for maintainance
Message-ID: <20040118160217.GA16364@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20040117163258.GA30150@work.bitmover.com> <20040117181951.GA30980@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117181951.GA30980@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgraded to 2.4.24 on the advice of many folks (thanks).  I ran a script
which backups up all the repos to a second disk and then another which ran
BK's integrity checker on each repo; all passed and no crashes.  We'll see
if this setup works better, we were getting kernel oops about once every
36 hours and I suspected the power and/or cooling in the 2U rack unit.

In case this doesn't work, I bought a 2Ghz Athlon uniprocessor and
have been burning it in.  If the current machine keeps crashing I'll
declare that hardware flakey and switch over after getting some more ram
(bkbits.net has 2GB).

On Sat, Jan 17, 2004 at 10:19:51AM -0800, Larry McVoy wrote:
> We're back up, new case, quality power supply, running 2.4.22 (which I'm
> assuming is the right kernel to run, it seems to be what the distros are
> shipping).  Let me know if there are any problems.
> 
> On Sat, Jan 17, 2004 at 08:32:58AM -0800, Larry McVoy wrote:
> > We're going to try putting the data in a different machine and see if that 
> > is more stable.  Off the air in about 10 minutes, should be back by 9:30AM PST.
> > 
> > Reply to me directly with any issues, I'm not subscribed to the list.
> > -- 
> > ---
> > Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
> 
> -- 
> ---
> Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
