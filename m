Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267670AbUHYOup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267670AbUHYOup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267594AbUHYOrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:47:52 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:30691 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S267341AbUHYOrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:47:15 -0400
Date: Wed, 25 Aug 2004 07:47:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Greg Weeks <greg.weeks@timesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: Re: [patch] ppc ep8260 support under 2.6.6
Message-ID: <20040825144706.GE32539@smtp.west.cox.net>
References: <412B638E.80500@timesys.com> <20040824213035.GH4521@smtp.west.cox.net> <412C77E2.1000702@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412C77E2.1000702@timesys.com>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 07:28:34AM -0400, Greg Weeks wrote:
> Tom Rini wrote:
> 
> >On Tue, Aug 24, 2004 at 11:49:34AM -0400, Greg Weeks wrote:
> >
> > 
> >
> >>This is basic support for the Embedded Planet's ep8260 board. It doesn't 
> >>include MTD support. This patch unfortunatly doesn't apply to 2.6.8 just 
> >>to 2.6.6. The code isn't mine, though it was developed here at Timesys. 
> >>I just needed it running under 2.6.6.
> >>
> >>Signed-off-by: Greg Weeks <greg.weeks@timesys.com> under TS0057
> >>   
> >>
> >
> >Note the reason it doesn't apply is that ep8260 (rpx8260) went into
> >2.6.8. :)
> >
> > 
> >
> That's even better. :)
> 
> >If you have access to the board, could you give it a shot in the
> >linuxppc-2.5 tree?  There's fcc changes in there that I'd like to get
> >tested on a few more boards before I push them out (or the driver gets
> >obsoleted).
> >
> Unfortunately I don't have bitkeeper access. Is there a tar ball of the 
> ppc tree? I didn't find one the last time I went looking.

There isn't one.  There is however, rsync.
rsync://source.mvista.com::linuxppc-2.5

-- 
Tom Rini
http://gate.crashing.org/~trini/
