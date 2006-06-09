Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWFIQEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWFIQEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbWFIQEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:04:45 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:22414 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030251AbWFIQEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:04:43 -0400
Message-ID: <44899C17.4080808@garzik.org>
Date: Fri, 09 Jun 2006 12:04:39 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	<4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	<44898EE3.6080903@garzik.org> <m3r71ycprd.fsf@bzzz.home.net>	<44899778.1010705@garzik.org> <m3mzcmcoks.fsf@bzzz.home.net>	<4489993D.7070203@garzik.org> <m3ejxyco6v.fsf@bzzz.home.net>
In-Reply-To: <m3ejxyco6v.fsf@bzzz.home.net>
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
>  JG> Alex Tomas wrote:
>  >> at the moment there is no way to "boot w/ extents". you must enable
>  >> them by mount option.
> 
>  JG> Think about how distros will deploy this feature.  Also, think about
>  JG> how scalable that line of thinking is...
> 
> I may be wrong, but I tend to think if they're stupid enough to enable
> experimental mount option by default, they can do s/ext3/ext4 as well.

<sigh>  At some point in the future, it will not be experimental.

	Jeff



