Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUC3XYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUC3XYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:24:09 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:17261 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261667AbUC3XWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:22:01 -0500
Message-ID: <406A0145.4070306@blueyonder.co.uk>
Date: Wed, 31 Mar 2004 00:22:45 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm1
References: <4069DC40.3070703@blueyonder.co.uk>	 <1080681249.3547.51.camel@watt.suse.com>	 <4069ED67.5050302@blueyonder.co.uk> <1080684268.3529.72.camel@watt.suse.com> <4069F9AC.4070601@blueyonder.co.uk>
In-Reply-To: <4069F9AC.4070601@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Mar 2004 23:22:01.0263 (UTC) FILETIME=[CDE3D3F0:01C416AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce wrote:

> Chris Mason wrote:
>
>> On Tue, 2004-03-30 at 16:57, Sid Boyce wrote:
>>  
>>
>>> Chris Mason wrote:
>>>
>>>   
>>>
>>>> On Tue, 2004-03-30 at 15:44, Sid Boyce wrote:
>>>>
>>>>
>>>>     
>>>>
>>>>> It builds fine on x86_64 but locks up solid at ----
>>>>> found reiserfs format "3.6" with standard journal
>>>>> Hard disk light permanently on - 2.6.5-rc2 vanilla is the last one 
>>>>> to boot fully, haven't tried 2.6.5-rc3 vanilla yet.
>>>>>  
>>>>>       
>>>>
>>>> Have you tried booting with acpi=off?
>>>>
>>>>     
>>>
>>> With acpi=off, I get a string of messages
>>>   
>>
>>
>> Try pci=noacpi
>>
>> -chris
>>
>>
>>
>>  
>>
> Same result, locks up in the same place, I'm going to build 2.6.5-rc3 
> vanilla now.
> Regards
> Sid.
>
2.6.5-rc2 booting OK(with acpi), anything else 2.6.5-rc2-mm?,  2.6.5-rc3 
or2.6.5-rc3-mm1 freezes.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

