Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTLXClz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 21:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbTLXCkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 21:40:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29085 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263513AbTLXCi4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 21:38:56 -0500
Message-ID: <3FE8FC2E.3080701@pobox.com>
Date: Tue, 23 Dec 2003 21:38:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andres Salomon <dilinger@voxel.net>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, jt@hpl.hp.com
Subject: Re: [PATCH 5/7] more CardServices() removals (drivers/net/wireless)
References: <1072229780.5300.69.camel@spiral.internal> <20031223182817.0bd3dd3c.akpm@osdl.org>
In-Reply-To: <20031223182817.0bd3dd3c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andres Salomon <dilinger@voxel.net> wrote:
> 
>>Part 5 of 7.
>>
>>
>>[005-cs_remove.patch  text/x-patch (6824 bytes)]
>> Revision: linux--mainline--2.6--patch-18
>> Archive: dilinger@voxel.net--2003-spiral
>> Creator: Andres Salomon <dilinger@voxel.net>
>> Date: Sun Dec 21 21:08:50 EST 2003
>> Standard-date: 2003-12-22 02:08:50 GMT
>> Modified-files: drivers/net/pcmcia/3c574_cs.c
> 
> 
> hmm, 3c574_cs was done in the other patch series.
> 
> I didn't receive patch 7/7.   Was there one?
> 
> Could you please aggregate these a bit?  One single patch for each driver
> subdir, say.


Ummm...  there are many changes to the pcmcia net drivers in my 
net-drivers-2.5-exp queue.  All can be classified as fixes, to a greater 
or lesser degree, and I would put those at a higher priority than API 
cleanups and such.  Mainly patches from Russell King and Al Viro, but 
also some random fixes from lkml.

For the net drivers, please coordinate with me (and perhaps Russell 
King), otherwise it will turn into an even bigger mess.

My latest patchkits are always posted at
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/

	Jeff



