Return-Path: <linux-kernel-owner+w=401wt.eu-S932829AbWLSRYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932829AbWLSRYv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 12:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932833AbWLSRYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 12:24:51 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:43596 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932829AbWLSRYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 12:24:50 -0500
Date: Tue, 19 Dec 2006 12:24:32 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for
 2.6.19]
In-reply-to: <20061219171123.GB25507@nostromo.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Nottingham <notting@redhat.com>, Diego Calleja <diegocg@gmail.com>,
       Marek Wawrzyczny <marekw1977@yahoo.com.au>
Message-id: <200612191224.32247.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <MDEHLPKNGKAHNMBLJOLKCEAPAGAC.davids@webmaster.com>
 <200612191146.30383.gene.heskett@verizon.net>
 <20061219171123.GB25507@nostromo.devel.redhat.com>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 12:11, Bill Nottingham wrote:
>Gene Heskett (gene.heskett@verizon.net) said:
>> FWIW:
>> [root@coyote src]# python list-kernel-hardware.py
>> Traceback (most recent call last):
>>   File "list-kernel-hardware.py", line 70, in ?
>>     ret = pciids_to_names(data)
>>   File "list-kernel-hardware.py", line 11, in pciids_to_names
>>     pciids = open('/usr/share/misc/pci.ids', 'r')
>> IOError: [Errno 2] No such file or directory:
>> '/usr/share/misc/pci.ids'
>>
>> That file apparently doesn't exist on an FC6 i686 system
>
>s/misc/hwdata/ for FC and derivatives.
>
>Bill

Ah, thanks.  Verbose isn't it?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
