Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbTF1Nwt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 09:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbTF1Nws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 09:52:48 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:42961 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S265215AbTF1Nwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 09:52:47 -0400
Date: Sat, 28 Jun 2003 07:07:00 -0700
From: Larry McVoy <lm@bitmover.com>
To: Scott McDermott <vaxerdec@frontiernet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: bkbits.net is down
Message-ID: <20030628140700.GB6053@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Scott McDermott <vaxerdec@frontiernet.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@bitmover.com>
References: <20030627145727.GB18676@work.bitmover.com> <Pine.LNX.4.21.0306271228200.17138-100000@ns.snowman.net> <20030627163720.GF357@zip.com.au> <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk> <20030627235150.GA21243@work.bitmover.com> <20030627165519.A1887@beaverton.ibm.com> <20030628001625.GC18676@work.bitmover.com> <20030627205140.F29149@newbox.localdomain> <20030628031920.GF18676@work.bitmover.com> <20030628040840.V9583@newbox.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030628040840.V9583@newbox.localdomain>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 04:08:40AM -0400, Scott McDermott wrote:
> > bkbits is 45GB of data and growing.  Tapes are completely
> > impractical, that's why we have hot spares.
> 
> You've got to be kidding.  My AIT2 tapes do 50G each,
> uncompressed.  Those are years old technology.  I have a
> Qualstar library only a few thousand dollars that has 20
> tape slots.

I haven't had much luck with tape, I've found them to be fairly unreliable
and slow over the years.  I've moved to using disk as backup and it works.
It worked quite nicely in this case, I had a handful of places I needed
random access to in order to fix up the problem.  Tape would have sucked.

> > > how about SCSI?
> > 
> > The raid system that failed is SCSI.
> 
> ok, well I stand corrected here, I thought you were using  IDE.

It's a mix: 1 IDE, one 3ware SCSI/IDE, and one real SCSI.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
