Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbTHaQS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbTHaQS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:18:28 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:61640 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262342AbTHaQS1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:18:27 -0400
Date: Sun, 31 Aug 2003 09:18:18 -0700
From: Larry McVoy <lm@bitmover.com>
To: Dan Kegel <dank@kegel.com>
Cc: Daniel Jacobowitz <dan@debian.org>, GCC Mailing List <gcc@gcc.gnu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: LMbench as gcc performance regression test?
Message-ID: <20030831161818.GB18767@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dan Kegel <dank@kegel.com>, Daniel Jacobowitz <dan@debian.org>,
	GCC Mailing List <gcc@gcc.gnu.org>, linux-kernel@vger.kernel.org
References: <3F51A201.8090108@kegel.com> <20030831152449.GA6893@nevyn.them.org> <3F521B4E.10909@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F521B4E.10909@kegel.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 08:59:10AM -0700, Dan Kegel wrote:
> I need to make sure that moving to a newer compiler for our kernel
> will cause no performance regressions.  

Perhaps people think that you mean to compile LMbench w/ different GCC's and
maybe what you really mean is compile the same kernel with different GCC's
and measure that.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
