Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263286AbTJQCfK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 22:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbTJQCfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 22:35:10 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:45221 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263286AbTJQCfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 22:35:07 -0400
Date: Thu, 16 Oct 2003 19:34:37 -0700
From: Larry McVoy <lm@bitmover.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc reliability & performance
Message-ID: <20031017023437.GB28158@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1066356438.15931.125.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066356438.15931.125.camel@cube>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 10:07:18PM -0400, Albert Cahalan wrote:
> I created a process with 360 thousand threads,

And your real need for 360,000 threads is?

I tend to believe that there are hundreds, nay, thousands, nay, 360 thousand
better things to work on in the kernel.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
