Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTF0OmF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTF0OmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:42:05 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:55471 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264394AbTF0OmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:42:03 -0400
Date: Fri, 27 Jun 2003 07:56:07 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jan de Groot <admin@jgc.homeip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serverworks OSB4 issues
Message-ID: <20030627145607.GA18676@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jan de Groot <admin@jgc.homeip.net>, linux-kernel@vger.kernel.org
References: <1256.212.187.32.129.1056725249.squirrel@jgc.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1256.212.187.32.129.1056725249.squirrel@jgc.homeip.net>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For what it is worth, I have this on bkbits.net:
    ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
    ServerWorks OSB4: chipset revision 0
    ServerWorks OSB4: not 100% native mode: will probe irqs later

and I ran 2.4.21 for a day or so before chickening out and downgrading to
2.4.20.  I did not see any errors and I did run a full set of integrity
checks over all the data (BK checks, not an fsck, BK checks read and 
checksum all the data).

I did get what looked like nasty corruption under 2.5.70.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
