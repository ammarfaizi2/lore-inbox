Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264754AbTFYRMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbTFYRMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:12:51 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:24003 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264754AbTFYRMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:12:47 -0400
Date: Wed, 25 Jun 2003 10:26:49 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: bkbits.net is down
Message-ID: <20030625172649.GB25213@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030621135812.GE14404@work.bitmover.com> <20030621190944.GA13396@work.bitmover.com> <20030622002614.GA16225@work.bitmover.com> <20030623053713.GA6715@work.bitmover.com> <20030625013302.GB2525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030625013302.GB2525@work.bitmover.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're up to the projects starting with "p" and through all the ppc trees.
So far everything is checking out clean after a few manual fixups.

We "downgraded" to 2.4.21 from ~2.5.70 because of what we think are file
system or IDE corruption problems.  If anyone else is running on a 
serverworks IDE chipset (Tyan dual PIII MB) and has hit problems with
2.4.21 I'd be deeply grateful for a heads up.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
