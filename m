Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270738AbTGUWDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 18:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270743AbTGUWDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 18:03:24 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:50850 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270738AbTGUWDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 18:03:23 -0400
Date: Mon, 21 Jul 2003 15:18:18 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@bitmover.com>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-ID: <20030721221818.GB7240@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
References: <20030721190226.GA14453@matchmail.com> <20030721194514.GA5803@work.bitmover.com> <20030721212155.GF4677@x30.linuxsymposium.org> <20030721213159.GA7240@work.bitmover.com> <20030721220000.GG4677@x30.linuxsymposium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030721220000.GG4677@x30.linuxsymposium.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 06:00:00PM -0400, Andrea Arcangeli wrote:
> since we're talking about bkcvs, I also would have a feature wish for
> the repository export in rsync.kernel.org: would it be possible to
> export a sequence number increased once before a transfer

I don't manage the rsync trees, HPA does that.  Peter?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
