Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270459AbTGSSa7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 14:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270466AbTGSSa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 14:30:58 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:58584 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270459AbTGSSav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 14:30:51 -0400
Date: Sat, 19 Jul 2003 11:45:19 -0700
From: Larry McVoy <lm@bitmover.com>
To: Christoph Hellwig <hch@infradead.org>,
       Ga?l Le Mignot <kilobug@freesurf.fr>, Larry McVoy <lm@bitmover.com>,
       Christian Reichert <c.reichert@resolution.de>,
       John Bradford <john@grabjohn.com>, lkml@lrsehosting.com,
       linux-kernel@vger.kernel.org, rms@gnu.org, Valdis.Kletnieks@vt.edu
Subject: Re: [OT] HURD vs Linux/HURD
Message-ID: <20030719184519.GB24197@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Christoph Hellwig <hch@infradead.org>,
	Ga?l Le Mignot <kilobug@freesurf.fr>, Larry McVoy <lm@bitmover.com>,
	Christian Reichert <c.reichert@resolution.de>,
	John Bradford <john@grabjohn.com>, lkml@lrsehosting.com,
	linux-kernel@vger.kernel.org, rms@gnu.org, Valdis.Kletnieks@vt.edu
References: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk> <1058626962.30424.6.camel@stargate> <plopm3lluu8mv0.fsf@drizzt.kilobug.org> <20030719172311.GA23246@work.bitmover.com> <plopm3he5i8l4h.fsf@drizzt.kilobug.org> <20030719181249.GA24197@work.bitmover.com> <20030719194123.A16317@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030719194123.A16317@infradead.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0,
	required 7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 07:41:23PM +0100, Christoph Hellwig wrote:
> On Sat, Jul 19, 2003 at 11:12:49AM -0700, Larry McVoy wrote:
> > The microkernel part of any reasonable microkernel is tiny.
> 
> And who says Mach is a reasonable microkernel :)

Yup, more like a maxikernel :)

That was my reaction on reading the code years ago and it hasn't changed.
I used to know one of the main guys who did the QNX microkernel (Dan
Hildebrandt, RIP 1998) and he talked about how a real microkernel was
never touched by more than 3 people and each of them spent as much
time removing stuff as adding it.

Mach is kinda on the bloated side, I always questioned the wisdom of
the GNU HURD being based on Mach, seemed like a bad call.  But then,
unless you have an extremely well controlled dev team, any micro kernel
is a bad call, it's going to bloat out.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
