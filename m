Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbTB0Pmo>; Thu, 27 Feb 2003 10:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTB0Pmo>; Thu, 27 Feb 2003 10:42:44 -0500
Received: from [213.133.112.210] ([213.133.112.210]:55564 "EHLO
	mail.pacebladeeurope.com") by vger.kernel.org with ESMTP
	id <S265276AbTB0Pmm>; Thu, 27 Feb 2003 10:42:42 -0500
Message-ID: <3E5E3483.7000302@paceblade.com>
Date: Thu, 27 Feb 2003 16:53:39 +0100
From: Robert Woerle Paceblade/Support <robert@paceblade.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.2.1) Gecko/20021130
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: "Grover, Andrew" <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: mem= option for broken bioses
References: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com> <20030226224450.GD15455@atrey.karlin.mff.cuni.cz> <3E5E2061.2060807@paceblade.com> <20030227151907.GC12434@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20030227151907.GC12434@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pavel Machek schrieb:

>Hi!
>
>  
>
>>>>OK, looks reasonable. Can you also gen up a patch documenting this in
>>>>kernel-parameters.txt?
>>>>  
>>>>
>>>>        
>>>>
>>>You can, assuming you took the patch ;-).
>>>
>>>
>>>      
>>>
>>well how can i find the correct value`s to put in ??
>>    
>>
>
>Well, similar method to how you use mem=123@456 parameters. You just
>guess them. [Given kernel messages, it is actually quite easy.]
>
>  
>
well .. wow ... what a accurate solution `????
...
..
.
well cant you tell me more ?

>  
>
>>>--- clean/Documentation/kernel-parameters.txt	2003-02-11 
>>>17:40:28.000000000 +0100
>>>+++ linux/Documentation/kernel-parameters.txt	2003-02-26 
>>>23:43:21.000000000 +0100
>>>@@ -516,6 +516,10 @@
>>>			[KNL,BOOT] Force usage of a specific region of memory
>>>			Region of memory to be used, from ss to ss+nn.
>>>
>>>+	mem=nn[KMG]#ss[KMG]
>>>+			[KNL,BOOT,ACPI] Mark specific memory as ACPI data.
>>>+			Region of memory to be used, from ss to ss+nn.
>>>+
>>>	mem=nopentium	[BUGS=IA-32] Disable usage of 4MB pages for kernel
>>>			memory.
>>>
>>>      
>>>
>
>
>  
>

-- 
_____________________________________
*Robert Woerle
**Technical Support | Linux
PaceBlade Technology Europe SA*
phone: +49 89 552 99935
fax: +49 89 552 99910
mobile: +49 179 474 45 27
email: robert@paceblade.com <mailto:robert@paceblade.com>
web: http://www.paceblade.com
_____________________________________





