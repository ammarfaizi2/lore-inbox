Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbTH3B3w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 21:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTH3B3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 21:29:52 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:39336 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262325AbTH3B3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 21:29:51 -0400
Date: Fri, 29 Aug 2003 18:29:49 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: bandwidth for bkbits.net (good news)
Message-ID: <20030830012949.GA23789@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI - we're working with several vendors to try and get more bandwidth
for bkbits.net.  We think we have a line on a deal where we can get a
full T1 just for bkbits.net for about $500/month.  If we get that then
we'll turn on the patch server feature so you can hit any URL and get a
regular diff -Nur style patch for that changeset (or range of changesets).

We've avoiding turning on that feature in the past because we share the
T1 line that bkbits.net lives on with all the rest of bitmover and we are
partialy a distributed company.  We do VOIP phones and when you guys clone
a repo our phones don't work - that makes us look bad during a sales call.
I'm not complaining, we get nice stress testing from bkbits so you should
hammer on it all you want but I'd like it if we could really encourage
that more.  Turning on a patch server should do the trick.

ETA on this is a month.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
