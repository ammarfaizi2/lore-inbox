Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbVI2TWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVI2TWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVI2TWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:22:21 -0400
Received: from dsl092-017-098.sfo4.dsl.speakeasy.net ([66.92.17.98]:28309 "EHLO
	baywinds.org") by vger.kernel.org with ESMTP id S932377AbVI2TWE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:22:04 -0400
Message-ID: <433C3E97.2040701@baywinds.org>
Date: Thu, 29 Sep 2005 12:20:55 -0700
From: Bruce Ferrell <bferrell@baywinds.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Stoffel <john@stoffel.org>
CC: Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org>	<433B0374.4090100@adaptec.com>	<20050928223542.GA12559@alpha.home.local>	<433BFB1F.2020808@adaptec.com> <17212.10714.576797.424890@smtp.charter.net>
In-Reply-To: <17212.10714.576797.424890@smtp.charter.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well said John!

For that matter get us a driver for the embedded 7902 (is that the one? 
  I forget now) with host raid support.



John Stoffel wrote:
> Luben,
> 
> I'd really prefer if you'd just stop on your tirade and just send in a
> 10 line patch for the existing linux SCSI subsystem to fix something
> you think is wrong. 
> 
> Code talks, bullshit walks.  
> 
> Sure, Linux SCSI might not be ideal, but how many people do you know
> have SAS storage on their home PCs right now?  Heck, I don't have SATA
> or PIV on my home system!  
> 
> And as a customer of Adaptec hardware, I'm getting to the point of
> seriously taking my money and going elsewhere for my storage needs.
> If you are a general example of how Adaptec works with its customers,
> then I want nothing to do with you or your products.  
> 
> Sure, I know you think Linux is stuck in the past, so help us move to
> the future in small baby steps.  It doesn't require big huge leaps
> like you're proposing.  I mean, have you actually tried to your old
> legacy SCSI controllers in a system with your new hardware?  How did
> your testing go?  
> 
> Now I'm not a programmer, and I can't talk like one, but in my real
> life job I'm a SysAdmin and knowing what I know about Adaptec's
> interactions on this list will certainly color my perceptions of your
> hardware and trying to make it work with my company.
> 
> John
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
