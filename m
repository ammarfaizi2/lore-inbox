Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTIYSau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTIYSaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:30:11 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:23183 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261738AbTIYS32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:29:28 -0400
Date: Thu, 25 Sep 2003 11:29:22 -0700
From: Larry McVoy <lm@bitmover.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030925182921.GA18749@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@bitmover.com>
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.44.0309251026550.29320-100000@home.osdl.org> <20030925122838.A16288@discworld.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925122838.A16288@discworld.dyndns.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 12:28:38PM -0600, Charles Cazabon wrote:
> Perhaps BitMover could release a client that can't do anything but keep a
> local (unmodified) tree in sync with a public repository tree, so that the
> "politically objectionable" (to some) parts of the BK license don't matter.
> 
> In an idea world, this read-only client could be released in source form, but
> I'm under no illusions there :).

People ask us for this all the time and it just highlights the point that
people don't understand how BK works.  It isn't client server, it's peer
to peer, every so-called client has to have all the smarts built in that
the so-called server has.  

There isn't any way to release a stripped down version that makes sense.
If there was, we would.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
