Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUC3W6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUC3Wwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:52:42 -0500
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:5559 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261784AbUC3Wth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:49:37 -0500
Message-ID: <4069F9AC.4070601@blueyonder.co.uk>
Date: Tue, 30 Mar 2004 23:50:20 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-mm1
References: <4069DC40.3070703@blueyonder.co.uk>	 <1080681249.3547.51.camel@watt.suse.com>	 <4069ED67.5050302@blueyonder.co.uk> <1080684268.3529.72.camel@watt.suse.com>
In-Reply-To: <1080684268.3529.72.camel@watt.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Mar 2004 22:49:36.0015 (UTC) FILETIME=[466E89F0:01C416A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

>On Tue, 2004-03-30 at 16:57, Sid Boyce wrote:
>  
>
>>Chris Mason wrote:
>>
>>    
>>
>>>On Tue, 2004-03-30 at 15:44, Sid Boyce wrote:
>>> 
>>>
>>>      
>>>
>>>>It builds fine on x86_64 but locks up solid at ----
>>>>found reiserfs format "3.6" with standard journal
>>>>Hard disk light permanently on - 2.6.5-rc2 vanilla is the last one to 
>>>>boot fully, haven't tried 2.6.5-rc3 vanilla yet.
>>>>   
>>>>
>>>>        
>>>>
>>>Have you tried booting with acpi=off?
>>>
>>>      
>>>
>>With acpi=off, I get a string of messages
>>    
>>
>
>Try pci=noacpi
>
>-chris
>
>
>
>  
>
Same result, locks up in the same place, I'm going to build 2.6.5-rc3 
vanilla now.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

