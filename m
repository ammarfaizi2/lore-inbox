Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUE2NWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUE2NWT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUE2NWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:22:18 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:18402 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264850AbUE2NUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:20:45 -0400
Date: Sat, 29 May 2004 06:20:38 -0700
From: Larry McVoy <lm@bitmover.com>
To: Hugo Mills <hugo-lkml@carfax.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       bitkeeper-announce@work.bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: bk-3.2.0 released
Message-ID: <20040529132038.GB20605@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Hugo Mills <hugo-lkml@carfax.org.uk>,
	Vojtech Pavlik <vojtech@suse.cz>,
	bitkeeper-announce@work.bitmover.com, linux-kernel@vger.kernel.org
References: <20040518233238.GC28206@work.bitmover.com> <20040529095419.GB1269@ucw.cz> <20040529130436.GA20605@work.bitmover.com> <20040529131510.GB13999@selene>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529131510.GB13999@selene>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 02:15:10PM +0100, Hugo Mills wrote:
> On Sat, May 29, 2004 at 06:04:36AM -0700, Larry McVoy wrote:
> > On Sat, May 29, 2004 at 11:54:20AM +0200, Vojtech Pavlik wrote:
> > > On Tue, May 18, 2004 at 04:32:38PM -0700, Larry McVoy wrote:
> > > > BK/Pro 3.2.0 has been released and is in the BK download area,
> > > > 
> > > >     http://bitmover.com/download
> > > 
> > > Any chance of a native x86-64 version? 
> > 
> > We don't have any x86-64 machines but we could get one.  I asked about this
> > a while back and people told me that there was no point, the x86 one worked
> > perfectly.  Can you tell me what having a native one would gain?  If there
> > is any gain we'll do it.
> 
>    It'll allow BK to be run on machines which have a pure 64-bit
> userspace (for example, Debian's current amd64 port), without having
> to resort to a 32-bit chroot to run the 32-bit BK binary.

OK, that's more than enough of a reason.  We'll get a native one in the next
week or so.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
