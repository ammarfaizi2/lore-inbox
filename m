Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264254AbUD0SMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbUD0SMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUD0SKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:10:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60378 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264254AbUD0SH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:07:56 -0400
Message-ID: <408EA16C.4030102@pobox.com>
Date: Tue, 27 Apr 2004 14:07:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@suse.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, akpm@osdl.org
Subject: Re: I oppose Chris and Jeff's patch to add an unnecessary additional
 namespace to ReiserFS
References: <1082750045.12989.199.camel@watt.suse.com> <408D3FEE.1030603@namesys.com> <20040426203314.A6973@infradead.org> <408E986F.90506@namesys.com> <20040427183400.A20221@infradead.org> <408E9F42.2080804@namesys.com>
In-Reply-To: <408E9F42.2080804@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Christoph Hellwig wrote:
> 
>>> Did you notice that V4 blows XFS and ReiserFS V3 away in 
>>> benchmarks?    That is what I have been doing for 3 years....
>>>
>>> See www.namesys.com for details.
>>>   
>>
>>
>> see www.microsoft.com why Windows is much better than Linux.  Yeah, 
>> thanks.
>>  
>>
> Ask the users whether their laptops, etc.,  seem to go a lot faster with 
> V4.  They seem to be pretty happy with it.
> 
> V4 fixed all of V3's serious performance flaws, and totally obsoletes 
> it.    I am very happy with it.


For the present thread, this is irrelevant, as the irreverent responses 
hinted at:

Regardless of _any_ features or fixes in V4, reiserfs V3 will be used in 
production system for years.  Minor feature additions to an existing 
filesystem make it far easier for kernel engineers and sysadmins to 
assess the impact on their systems -- which is typically of less impact 
than switching to a new filesystem.

	Jeff



