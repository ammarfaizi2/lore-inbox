Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbTI2PHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTI2PHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:07:15 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:61866 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263515AbTI2PHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:07:13 -0400
Date: Mon, 29 Sep 2003 08:07:07 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rob Landley <rob@landley.net>
Cc: Larry McVoy <lm@bitmover.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: log-buf-len dynamic
Message-ID: <20030929150707.GB31116@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rob Landley <rob@landley.net>, Larry McVoy <lm@bitmover.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <20030925122838.A16288@discworld.dyndns.org> <20030925182921.GA18749@work.bitmover.com> <200309290356.27600.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309290356.27600.rob@landley.net>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 03:56:27AM -0500, Rob Landley wrote:
> And the reason Andrea hasn't found bitkeeper to be nicer than CVS is he isn't 
> trying to integrate the work of 300 other developers into his personal tree 
> simultaneously.  BK is really just a merging tool that fixes rejects 
> automatically, everything else is details...
> 
> Am I wrong?

I think so.  That's sort of like saying "the kernel is really just a program
that multiplexes processes".  Both are true statements if you look at the 
world that way but both dramatically underestimate the real picture.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
