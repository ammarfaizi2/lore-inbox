Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbTGCEzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 00:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbTGCEzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 00:55:08 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:53187 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S265125AbTGCEzF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 00:55:05 -0400
Date: Wed, 2 Jul 2003 22:08:35 -0700
From: Larry McVoy <lm@bitmover.com>
To: Patrick Mansfield <patmans@us.ibm.com>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, CaT <cat@zip.com.au>,
       nick@snowman.net, Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030703050835.GA4751@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Patrick Mansfield <patmans@us.ibm.com>,
	Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	CaT <cat@zip.com.au>, nick@snowman.net,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030627145727.GB18676@work.bitmover.com> <Pine.LNX.4.21.0306271228200.17138-100000@ns.snowman.net> <20030627163720.GF357@zip.com.au> <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk> <20030627235150.GA21243@work.bitmover.com> <20030627165519.A1887@beaverton.ibm.com> <20030628001625.GC18676@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030628001625.GC18676@work.bitmover.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 3ware SATA 8500-4 controller with 4x WD 36GB Raptor SATA drives.
Wow.  Just "wow".  At least a factor of 2 better than what I've seen 
before.  I think a boatload of that is the 5ms seek time, gotta love 
that.  

I'm burning them in, if they work then we'll use those for bkbits.net.
If you guys need me to run any tests/kernels against this mix let me
know.

These are nice drives.  I got 4 drives and the controller from newegg
for about $950 shipped including tax.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
