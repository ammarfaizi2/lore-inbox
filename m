Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263064AbUJ1NbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbUJ1NbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbUJ1NbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:31:12 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:15298 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S263064AbUJ1Na6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:30:58 -0400
Message-ID: <4180F415.8030409@ttnet.net.tr>
Date: Thu, 28 Oct 2004 16:28:53 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, malware@t-online.de
Subject: Re: Linux 2.4.28-rc1
References: <417E5904.9030107@ttnet.net.tr> <20041026203334.GB29688@logos.cnet> <417F9731.5040101@ttnet.net.tr> <20041028095429.GH4815@logos.cnet>
In-Reply-To: <20041028095429.GH4815@logos.cnet>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Wed, Oct 27, 2004 at 03:40:17PM +0300, O.Sezer wrote:
> 
>>Marcelo Tosatti wrote:
>>
>>>Hi,
>>>
>>>If you have been suddenly CC'ed to this message please search
>>>your name below - there is something which concerns you.
>>>
>>>Replying only to the list, myself and O.Sezer is appreciated.
>>>
>>>On Tue, Oct 26, 2004 at 05:02:44PM +0300, O.Sezer wrote:
>>>
>>>
>>>>There are many lost/forgotten patches posted here on lkml. Since 2.4.28
>>>>is near and 2.4 is going into "deep maintainance" mode soon, I gathered
>>>>a short list of some of them. 
>>>
>>>
>>>Oh it is hard to bookkeep all of this. I hope people check and resend, but
>>>they dont do that always.
>>>
>>>
>>>
>>>>There, sure, are many more of them,  but here it goes.
>>>
>>>
>>>Please send'em all. I really appreciate your efforts.
>>
>>[...]
>>
>>>>- Michael Mueller: opti-viper pci-chipset support
>>>>(have an updated-for-2.4.23+ patch for this)
>>>>http://marc.theaimsgroup.com/?t=106698970100002&r=1&w=2
>>>>http://marc.theaimsgroup.com/?l=linux-kernel&m=106698965700864&w=2
>>>
>>>
>>>Should be applied - v2.6 also lacks it AFAICS.
>>
>>Attached is a one that's supposed to apply cleanly to and work
>>with 2.4.23+ kernels.
> 
> 
> Ozkan,
> 
> Someone needs to check v2.6.
> 
> Can you or Michael do that please?
> 
> I'll save it to 2.4.29pre. 
> 

2.6 doesn't have it but I don't know if it needs it (it should, but...)
I don't have the hardware anymore, so Michael can look after it, I'm
sure.
