Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbTFFDlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 23:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbTFFDlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 23:41:40 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:13189 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S265291AbTFFDlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 23:41:39 -0400
Date: Thu, 5 Jun 2003 20:55:11 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: BK->CVS back up
Message-ID: <20030606035511.GA16184@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.6,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recreated the trees from scratch.  I did not do extensive checks to make
sure these are OK but I did checkout the head of both the 2.4 and the 2.5
CVS trees and diffed them against the BK tree and they were the same.

No promises that the revision numbers stayed the same so if things seem 
weird throw away your CVS workspace and check them out again.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
