Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTFYBTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTFYBTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:19:08 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:50851 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263738AbTFYBS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:18:59 -0400
Date: Tue, 24 Jun 2003 18:33:02 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: bkbits.net is down
Message-ID: <20030625013302.GB2525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030621135812.GE14404@work.bitmover.com> <20030621190944.GA13396@work.bitmover.com> <20030622002614.GA16225@work.bitmover.com> <20030623053713.GA6715@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623053713.GA6715@work.bitmover.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And the saga continues (I really want to be a real CEO.  I've done some
research and I've found that golf isn't the only answer, fly fishing is
cool now too.  I already know how to do that, I'm even good at it, so
I should go close some deals :)

Anyway, we put 2.5.70 on bkbits.net which is a Tyan dual PII motherboard
w/ serverworks IDE and we started getting data corruption.  So I just
installed 2.4.21 and we'll see if that works better.  

Things are going to be a little slow for a while I run through integrity
checks on all the repos, there are 4.5 million files here so it takes a
while (you guys do generate a pile of data, I'll give you that).

More status as I have, bkbits is up now and you should be able to use it.
If you hit problems in specific repos let me know, I already know about
the ppc problems.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
