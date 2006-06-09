Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030292AbWFIQ2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWFIQ2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWFIQ2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:28:16 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:19599 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030260AbWFIQ2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:28:14 -0400
Message-ID: <4489A199.9050502@garzik.org>
Date: Fri, 09 Jun 2006 12:28:09 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>	<m33beecntr.fsf@bzzz.home.net> <44899D93.5030008@garzik.org> <m3verab8kg.fsf@bzzz.home.net>
In-Reply-To: <m3verab8kg.fsf@bzzz.home.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>> Jeff Garzik (JG) writes:
> 
>  JG> If it will remain a mount option, if it is never made the default
>  JG> (either in kernel or distro level), then only 1% of users will ever
>  JG> use the feature.  And we shouldn't merge a 1% use feature into the
>  JG> _main_ filesystem for Linux.
> 
> strictly speaking, not that many users really need >2TB fs ...

Not true.  Terabyte SATA drives are less than a year away.  2TB 
drives... probably 2 years?

	Jeff



