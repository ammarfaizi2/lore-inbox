Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbTF1DFK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 23:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbTF1DFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 23:05:10 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:18892 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S265037AbTF1DFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 23:05:07 -0400
Date: Fri, 27 Jun 2003 20:19:20 -0700
From: Larry McVoy <lm@bitmover.com>
To: Scott McDermott <vaxerdec@frontiernet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030628031920.GF18676@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Scott McDermott <vaxerdec@frontiernet.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030627145727.GB18676@work.bitmover.com> <Pine.LNX.4.21.0306271228200.17138-100000@ns.snowman.net> <20030627163720.GF357@zip.com.au> <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk> <20030627235150.GA21243@work.bitmover.com> <20030627165519.A1887@beaverton.ibm.com> <20030628001625.GC18676@work.bitmover.com> <20030627205140.F29149@newbox.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030627205140.F29149@newbox.localdomain>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 08:51:40PM -0400, Scott McDermott wrote:
> Larry McVoy on Fri 27/06 17:16 -0700:
> > I don't know if you all realize this but at one point we
> > had corrupted data in several repositories and the backups
> > were also shot.
> 
> ever hear of tapes?

bkbits is 45GB of data and growing.  Tapes are completely impractical,
that's why we have hot spares.

> how about SCSI?

The raid system that failed is SCSI.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
