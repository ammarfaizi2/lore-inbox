Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUCPTRS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUCPTRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:17:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60380 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261368AbUCPTQX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:16:23 -0500
Message-ID: <40575279.7040408@pobox.com>
Date: Tue, 16 Mar 2004 14:16:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, bos@serpentine.com,
       linux-raid@vger.kernel.org
Subject: Re: [PATCH] klibc update
References: <4056B0DB.9020008@pobox.com>	<20040316005229.53e08c0c.akpm@osdl.org>	<20040316153719.GA13723@kroah.com> <20040316111026.6729e153.akpm@osdl.org>
In-Reply-To: <20040316111026.6729e153.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> 
>>On Tue, Mar 16, 2004 at 12:52:29AM -0800, Andrew Morton wrote:
>>
>>>It's so long since klibc was discussed (ie: more than five minutes ago)
>>>that I forget the reasons why it should be delivered via the kernel tree.
>>>
>>>Remind me please?
>>
>>We need a way to build the userspace programs that get put into
>>initramfs that will be needed to boot the kernel.
>>
>>That help?
> 
> 
> My grey cells thank you.
> 
> Does klibc have a bk home anywhere, so I can start sucking it in?
> 
> 

There is the one I subtlely posted in my original email :)
	bk://kernel.bkbits.net/jgarzik/klibc-2.5

Bryan O'Sullivan and Greg KH at varying times in the past had BK trees, 
but I didn't know of any up-to-date one.

Note that it isn't my intention to become klibc maintainer...  just in 
case anybody started getting ideas... :)

	Jeff



