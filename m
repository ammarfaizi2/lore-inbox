Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbVIIRfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbVIIRfd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbVIIRfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:35:33 -0400
Received: from mail-out2.fuse.net ([216.68.8.175]:24813 "EHLO smtp2.fuse.net")
	by vger.kernel.org with ESMTP id S1030286AbVIIRfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:35:32 -0400
Message-ID: <43211FDD.6000508@fuse.net>
Date: Fri, 09 Sep 2005 01:38:37 -0400
From: rob <rob.rice@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: swsusp
References: <431E97E5.1080506@fuse.net> <431F42D0.6080304@gmail.com> <4321179B.6080107@fuse.net>
In-Reply-To: <4321179B.6080107@fuse.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rob wrote:

> Alon Bar-Lev wrote:
>
>> rob wrote:
>>
>>> I singed up to this mailing list just to ask this question
>>> I have built a 2.6.13 kernel for a toshiba  tecra 500cdt
>>> this computer uses the pci buss for the sound card
>>> and pcmcia bridge
>>> I have writen a script to unload all the pci buss modules amd go to 
>>> sleep
>>> it works up to this point
>>> now how do I get the modules put back when ever I add the lines to
>>> rerun the " /etc/rc.d/rc.hotplug /etc/rc.d/rc.pcmcia and 
>>> /etc/rc.d/rcmodules "
>>> I get a kernel crash befor it gose to sleep
>>> I have been al over the net and the olny info I can find is about 
>>> software suspend2
>>> Is there some way to change the sowftware suspend2 scripts to work 
>>> with the
>>> unpatched kernel software suspend or where can I get the path to init
>>> talked about in the menuconfig file
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe 
>>> linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>> I am using suspend2 (www.suspend2.net) which works very well... Have 
>> you considered it?
>>
>> Best Regards,
>> Alon Bar-Lev.
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> it crashes the kernel with atempt to kill init or it trys to load a 
> memory image that was never saved
> I can't get it to boot for the first time so it can save a memory image
>

