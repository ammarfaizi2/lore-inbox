Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267956AbTBYOm1>; Tue, 25 Feb 2003 09:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267970AbTBYOm1>; Tue, 25 Feb 2003 09:42:27 -0500
Received: from [213.133.112.212] ([213.133.112.212]:40709 "EHLO
	mail.symplon.com") by vger.kernel.org with ESMTP id <S267956AbTBYOm0>;
	Tue, 25 Feb 2003 09:42:26 -0500
Message-ID: <3E5B835E.7050601@symplon.com>
Date: Tue, 25 Feb 2003 15:53:18 +0100
From: Robert <robert.woerle@symplon.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.2.1) Gecko/20021130
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Ducrot Bruno <ducrot@poupinou.org>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Robert Woerle <robert@paceblade.com>
Subject: Re: [ACPI] PaceBlade broken acpi/memory map
References: <20030220172144.GA15016@elf.ucw.cz> <20030224164209.GD13404@poup.poupinou.org> <20030224183955.GC517@atrey.karlin.mff.cuni.cz> <20030225143505.GH13404@poup.poupinou.org>
In-Reply-To: <20030225143505.GH13404@poup.poupinou.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ducrot Bruno schrieb:

>On Mon, Feb 24, 2003 at 07:39:55PM +0100, Pavel Machek wrote:
>  
>
>>Hi!
>>
>>    
>>
>>>>I have PaceBlade here, and its memory map is wrong, which leads to
>>>>ACPI refusing to load. [It does not mention "ACPI data" in the memory
>>>>map at all!]
>>>>        
>>>>
>>>I have made those patches to workaround that.  I have no time
>>>      
>>>
>>Yes, I have seen those... I also made a patch that enables you to do
>>that workaround from mem= options at kernel command line.
>>
>>    
>>
>
>I doubt you received the latest one, since I have not make it public
>unless this day.
>  
>
i did sent it to him since he recieved our machine from Suse Nuernberg

>  
>

