Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbUDWVMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUDWVMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUDWVMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:12:16 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:36871 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261440AbUDWVMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:12:13 -0400
Message-ID: <4089875F.1010207@techsource.com>
Date: Fri, 23 Apr 2004 17:15:11 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
CC: Paul Jackson <pj@sgi.com>, tytso@mit.edu, miquels@cistron.nl,
       linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu>
In-Reply-To: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Joel Jaeggli wrote:
> On Fri, 23 Apr 2004, Paul Jackson wrote:
> 
> 
>>>SO... in addition to the brilliance of AS, is there anything else that 
>>>can be done (using compression or something else) which could aid in 
>>>reducing seek time?
>>
>>Buy more disks and only use a small portion of each for all but the
>>most infrequently accessed data.
> 
> 
> faster drives. The biggest disks at this point are far slower that the 
> fastest... the average read service time on a maxtor atlas 15k is like 
> 5.7ms on 250GB western digital sata, 14.1ms, so that more than twice as 
> many reads can be executed on the fastest disks you can buy now... of 
> course then you pay for it in cost, heat, density, and controller costs. 
> everthing is a tradeoff though.


I had this idea of packing a bunch of those really tiny Toshiba 
quarter-sized drives and some sort of RAID0 controller into a box the 
size of a 3.5" hard drive.


