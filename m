Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265420AbTF1Urk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 16:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265441AbTF1Urk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 16:47:40 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:25815 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S265438AbTF1UqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 16:46:21 -0400
Date: Sat, 28 Jun 2003 14:00:30 -0700
From: Larry McVoy <lm@bitmover.com>
To: David Schwartz <davids@webmaster.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030628210030.GG18676@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Schwartz <davids@webmaster.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1056832290.6289.44.camel@dhcp22.swansea.linux.org.uk> <MDEHLPKNGKAHNMBLJOLKMEAJEAAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEAJEAAA.davids@webmaster.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 01:55:11PM -0700, David Schwartz wrote:
> 
> > On Sad, 2003-06-28 at 20:38, Dr. David Alan Gilbert wrote:
> 
> > > Tapes are a pain; but at the type of 40GB range is it worth considering
> > > a pile of external USB/Firewire hard drives?
> 
> > I'm testing the USB2 disk idea at the moment. Big problem is performance
> > - 5Mbytes/second isnt the best backup rate in the world.
> 
> 	If the issue is the time the backup itself takes, 2 hours isn't a big deal,
> it'll finish over a long lunch break. If the issue is having to lock out
> write access or otherwise stabilize the actual data for the time it takes to
> backup, just stage a copy of the backup to a local disk and then backup to
> external disk from there.

If we're talking about BK, BK already has repository level locking to get 
stable snapshots.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
