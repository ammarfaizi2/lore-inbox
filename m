Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTCTTbD>; Thu, 20 Mar 2003 14:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTCTTbD>; Thu, 20 Mar 2003 14:31:03 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:55729 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261855AbTCTTbA>;
	Thu, 20 Mar 2003 14:31:00 -0500
Message-ID: <3E7A1871.4090505@us.ibm.com>
Date: Thu, 20 Mar 2003 14:37:21 -0500
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bugs sitting in the NEW state for more than two weeks
References: <3E79D1AD.5080803@us.ibm.com> <20030320182135.GD1757@Master.Wizards>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Murray J. Root wrote:

> On Thu, Mar 20, 2003 at 09:35:25AM -0500, Stacy Woods wrote:
> 
>> There are 101 bugs sitting in the NEW state for more than 2 weeks
>> that don't appear to have any activity. 48 of these bugs are owned
>> by bugme-janitors which are good candidates for anyone to work on.
>> Please check the bugs for before working on them to see if they are
>> still available.
>> 
>> Kernel Bug Tracker: http://bugme.osdl.org
>> 
>> 
> ...
> 
>> 387 Other Other bugme-janitors@lists.osdl.org
>> poll on usb device does not return immediatly when device is unplugged
>> 
>> 388 Other Other bugme-janitors@lists.osdl.org
>> 2.5.60/ioctl on usb device returns wrong length
>> 
>> 390 Other Other bugme-janitors@lists.osdl.org
>> System hang with MySql workload
> 
> ...
> 
> 389 is still in "new" state but doesn't appear in list
> 
> ...
>  
> 
>> 410  Platform   i386       mbligh@aracnet.com
>> unexpected IO-APIC, please file a report at http://bugzilla.kernel.org
>> 
>> 415  Drivers    Video(DR   bugme-janitors@lists.osdl.org
>> aty128fb.c fails to compile (logic error)
>> 
>> 417  File Sys   ext3       akpm@digeo.com
>> htree much slower than regular ext3
> 
> ...
> 
> 413 is still in "new" state but does not appear in list
> 
> it seems your script is sorting by more than just age.
> 
> If severity "normal" means "ignore" it should be indicated - I'll start 
> claiming a higher level.
> 
Murray,
  Bugs 389 and 413 show the "last update" date was  March 12th which 
dosen't fall
within the two week criteria.    The search is done only on the "last 
update" and
has nothing to do with severity.    Since you added comments to those 
bugs it set
the date then.   I realize this is not a perfect system to list all bugs 
that are truly
not being worked on,  but hopefully it gets some bugs investigated  
Especially the
ones owned by bugme-janitors.

- Stacy

