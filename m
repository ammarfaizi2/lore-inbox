Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbTHWTPK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 15:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbTHWTPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 15:15:09 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:65256 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262567AbTHWTPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 15:15:04 -0400
Date: Sat, 23 Aug 2003 12:14:58 -0700
From: Larry McVoy <lm@bitmover.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: *sigh* something is wrong with bkcvs again
Message-ID: <20030823191458.GA25535@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
References: <20030823012724.GC31894@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823012724.GC31894@vitelus.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is your message recast in the context of the kernel, or at least 
this is what it sounded like to me:

    *Sigh*.  The kernel oops *again*.  How dare you give me this kernel
    for free and then break it.  Fix it, right now, and I'd like an
    apology along with the fix.  Hurry up.

Maybe you didn't intend it to sound like that and you'd like to rephrase it.

On Fri, Aug 22, 2003 at 06:27:24PM -0700, Aaron Lehmann wrote:
> At the *root* of a fresh checkout:
> 
> $ head -2 Makefile 
> #
> # Copyright (c) 2000-2003 Silicon Graphics, Inc.  All Rights Reserved.
> 
> It's the XFS makefile...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
