Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVDPCgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVDPCgw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 22:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVDPCgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 22:36:52 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:31977 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262581AbVDPCgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 22:36:39 -0400
Message-ID: <42607A33.6010008@myrealbox.com>
Date: Fri, 15 Apr 2005 19:36:35 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [SATA] status reports updated
References: <42600375.9080108@pobox.com>
In-Reply-To: <42600375.9080108@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> My Linux SATA software/hardware status reports have just been updated. 
> To see where libata (SATA) support stands for a particular piece of 
> hardware, or a particular feature, go to
> 
>     http://linux.yyz.us/sata/

What's the timeline on getting sata-promise's PATA support into 
mainline?  I've been 2.6.11-gentoo-r2, which includes this feature, for 
weeks now, and it's been perfectly stable (including md's RAID5) using 
the PATA port.  It would be nice to be able to run my system with a 
mainline kernel.

The broken-out patch that Gentoo is using is here:

http://dev.gentoo.org/~dsd/gentoo-dev-sources/release-11.01/dist/4320_promise-pdc2037x.patch

Thanks,
Andy
