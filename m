Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTDONMf (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbTDONMf 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:12:35 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:27305 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261360AbTDONMe 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 09:12:34 -0400
Date: Tue, 15 Apr 2003 06:24:20 -0700
From: Larry McVoy <lm@bitmover.com>
To: Dominik Kubla <dominik@kubla.de>
Cc: Chris Wedgwood <cw@f00f.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ECC error in 2.5.64 + some patches
Message-ID: <20030415132420.GA11659@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dominik Kubla <dominik@kubla.de>, Chris Wedgwood <cw@f00f.org>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <20030324212813.GA6310@osiris.silug.org> <20030327160220.GA29195@work.bitmover.com> <20030327170039.GA26452@f00f.org> <200303271819.41971.dominik@kubla.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303271819.41971.dominik@kubla.de>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 06:19:41PM +0100, Dominik Kubla wrote:
> Am Donnerstag, 27. M?rz 2003 18:00 schrieb Chris Wedgwood:
> 
> > > Message from syslogd@slovax at Thu Mar 27 05:53:49 2003 ...
> > > slovax kernel: Bank 1: 9000000000000151
> >
> > Status: (9000000000000151) Restart IP valid.
> >
> > *Exactly* what this means I don't know --- but I'm guessing the CPU is
> > overheating.  Check fans, air-flow, etc. and see if that helps.  So
> > far whenever I've seen the above problem it's *ALWAYS* been related to
> > the CPU getting too hot.

FYI - it was a too small case with the power supply sitting more or less
on top of the CPU.  Moving everything to a bigger case fixed it.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
