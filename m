Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbTF1TEq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 15:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265358AbTF1TEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 15:04:46 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:50389 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S265352AbTF1TEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 15:04:44 -0400
Date: Sat, 28 Jun 2003 12:18:47 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Scott McDermott <vaxerdec@frontiernet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030628191847.GB8158@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Scott McDermott <vaxerdec@frontiernet.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030627145727.GB18676@work.bitmover.com> <Pine.LNX.4.21.0306271228200.17138-100000@ns.snowman.net> <20030627163720.GF357@zip.com.au> <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk> <20030627235150.GA21243@work.bitmover.com> <20030627165519.A1887@beaverton.ibm.com> <20030628001625.GC18676@work.bitmover.com> <20030627205140.F29149@newbox.localdomain> <20030628031920.GF18676@work.bitmover.com> <1056827655.6295.22.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056827655.6295.22.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 08:14:16PM +0100, Alan Cox wrote:
> On Sad, 2003-06-28 at 04:19, Larry McVoy wrote:
> > bkbits is 45GB of data and growing.  Tapes are completely impractical,
> > that's why we have hot spares.
> 
> Overhot spares included 8).
> 
> Hot spares wont save you always. I've worked at a telco where we lost
> all the disks. the hosts and the hot spares to a PSU failure. The
> replication has a lot going for it 8)

Yup.  We're looking at having replicas in at least 2, maybe 3 locations,
one in San Francisco, one in Texas, and one in either North Carolina
or in Oregon.  That should cover our butt for a while.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
