Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbTFYPb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbTFYPb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:31:57 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:19389 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264909AbTFYPb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:31:56 -0400
Date: Wed, 25 Jun 2003 08:46:02 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bkbits.net web UI oddities after last crash
Message-ID: <20030625154602.GA25213@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andre Tomt <andre@tomt.net>, linux-kernel@vger.kernel.org
References: <1056475651.7646.128.camel@slurv.ws.pasop.tomt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056475651.7646.128.camel@slurv.ws.pasop.tomt.net>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 07:27:31PM +0200, Andre Tomt wrote:
> Hi
> 
> I noticed some rather strange behavior from
> http://linux.bkbits.net:8080/linux-2.4

I put up a new release that used MD5 based names for revision numbers rather
than the revision numbers (sort of like naming a file by inode number) 
because the revision numbers shift around on you.  It has bugs.  Once we
work out the bugs the plus is that you'll be able to post a URL and it 
will always get people to the same data which is not true today.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
