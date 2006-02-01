Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWBAQMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWBAQMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWBAQMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:12:35 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:15100 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1422672AbWBAQMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:12:23 -0500
Message-ID: <43E0DE1F.4040809@tmr.com>
Date: Wed, 01 Feb 2006 11:13:19 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joshua Kugler <joshua.kugler@uaf.edu>
CC: jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] 8-port AHCI SATA Controller?
References: <20060131115343.GA2580@favonius> <200601310919.20199.joshua.kugler@uaf.edu>
In-Reply-To: <200601310919.20199.joshua.kugler@uaf.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kugler wrote:
> On Tuesday 31 January 2006 02:53, Sander wrote:
> 
>>Hello,
>>
>>I'm looking for an 8-port SATA controller based on the AHCI chipset, as
>>according to http://linux.yyz.us/sata/sata-status.html#vendor_support
>>this chipset is completely open.
>>
>>I've searched the websides of the companies which according to
>>http://linux.yyz.us/sata/sata-status.html#ahci base some of their
>>products on this chipset, but I couldn't find an 8-port controller.
>>
>>I've also googled, but without success, hence this somewhat offtopic
>>message. Although I hope the response helps others in their quest.
>>
>>The question: does an 8-port AHCI based SATA controller exist? And if,
>>where can I find it? 12, 16 or 24 ports will do too. I don't need HW
>>raid, just JBOD.
> 
> 
> I've run some tests with this card under Linux and done pretty well:
> 
> http://www.supermicro.com/products/accessories/addon/DAC-SATA-MV8.cfm
> 
> They also have a 3.0Gb version.
> 
> Not sure if that is AHCI, but it is eight port.
> 
> I got the drivers here:
> 
> http://www.keffective.com/mvsata/FC3/
> 
> The latest was mvSata_Linux_3.6.1.tgz as of 2005-10-13.
> 
> Hope that helps.

I get a "you do not have permission" using that link, for what it's worth.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
