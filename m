Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269034AbTCAVgI>; Sat, 1 Mar 2003 16:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269036AbTCAVgI>; Sat, 1 Mar 2003 16:36:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38661 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S269034AbTCAVgH>;
	Sat, 1 Mar 2003 16:36:07 -0500
Message-ID: <3E612A27.2050200@pobox.com>
Date: Sat, 01 Mar 2003 16:46:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Update to 2.5.x snapshots
References: <3E60FAAB.1080007@pobox.com> <20030301211611.GA23874@finwe.eu.org>
In-Reply-To: <20030301211611.GA23874@finwe.eu.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek Kawa wrote:
> Jeff Garzik wrote:
> 
> 
>>Old 2.5.x BK snapshots on kernel.org are now moved into the "old" 
>>sub-directory, instead of being deleted.
>>
>>The script change is untested... so yell at me if things break when 
>>Linus releases 2.5.64.
> 
> 
> It may not be related, but  
> http://www.kernel.org/pub/linux/kernel/v2.4/testing/cset/
> has "BitKeeper patches since v2.4.21-pre4: 354 Changesets"
> (not latest -pre).


Yep, I know :)

The point of nightly snapshots is more for users use and testing 
purposes.  The csets are very useful for developers, but a bit of a 
moving target for users.  If users are using the per-cset snapshots, 
then it becomes a non-trivial chore to developers to track down exactly 
what version of the kernel a problem is reported against.

	Jeff



