Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTIHA6C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 20:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTIHA6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 20:58:02 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:59316 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261823AbTIHA6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 20:58:00 -0400
Date: Sun, 7 Sep 2003 17:57:49 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Larry McVoy <lm@bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030908005749.GA24714@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Larry McVoy <lm@bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay> <20030903215135.GY4306@holomorphy.com> <116940000.1062625566@flay> <20030904010653.GD5227@work.bitmover.com> <m11xusnvqc.fsf@ebiederm.dsl.xmission.com> <20030907230729.GA19380@work.bitmover.com> <m1wuckma9z.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wuckma9z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 05:47:04PM -0600, Eric W. Biederman wrote:
> I have already built a 2304 cpu machine and am working on a 2900+ cpu
> machine.  

That's not "a machine" that's ~1150 machines on a network.  This business
of describing a bunch of boxes on a network as "a machine" is nonsense.

Don't get me wrong, I love clusters, in fact, I think what you are doing
is great.  It doesn't screw up the OS, it forces the OS to stay lean and
mean.  Goodness.

All the CC cluster stuff is about making sure that the SMP fanatics don't
screw up the OS for you.  We're on the same side.  Try not to be so rude
and have a bit more vision.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
