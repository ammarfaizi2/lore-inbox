Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965237AbWIFBPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbWIFBPZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 21:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965243AbWIFBPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 21:15:24 -0400
Received: from mail.tmr.com ([64.65.253.246]:52202 "EHLO roadwarrior3.tmr.com")
	by vger.kernel.org with ESMTP id S965237AbWIFBPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 21:15:24 -0400
Message-ID: <44F7A48B.7010405@tmr.com>
Date: Thu, 31 Aug 2006 23:10:03 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       yi.zhu@intel.com, jketreno@linux.intel.com,
       ipw2100-devel@lists.sourceforge.netAnd
Subject: Re: ipw2200: small cleanups
References: <20060831123004.GA3923@elf.ucw.cz> <Pine.LNX.4.61.0608311504480.16609@yvahk01.tjqt.qr> <20060831133529.GG3923@elf.ucw.cz>
In-Reply-To: <20060831133529.GG3923@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Thu 2006-08-31 15:05:45, Jan Engelhardt wrote:
>>> Remove dead, commented-out code, and switch to C-style commments.
>> Why can't we use C99 comments? We're already depending on so many GCC 
>> features that C-C99 is really nitpicky.
> 
> They look ugly to my eyes... 
> 								Pavel
>
And you can't forget to close them...



