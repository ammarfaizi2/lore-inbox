Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVFGRoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVFGRoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 13:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbVFGRoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 13:44:07 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:61455 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261941AbVFGRn6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 13:43:58 -0400
Message-ID: <42A5DD47.5090000@tmr.com>
Date: Tue, 07 Jun 2005 13:45:43 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Thonke <iogl64nx@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Pentium-D support
References: <42A5B80A.4040709@tmr.com> <42A5C8A3.2090202@gmail.com>
In-Reply-To: <42A5C8A3.2090202@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke wrote:
> Bill Davidsen schrieb:
> 
> 
>>Since this is really a question in several areas I'll put it here. Now
>>that the Pentium-D processors are available at reasonable prices and
>>for quick delivery, can anyone speak to the ACPI issues? The available
>>boards use the 945 and 955 chipset. Is there any reason to think that
>>the scheduler would get confused by the CPU, such as thinking it was
>>HT or some such?
> 
> 
> There are only issues with CPUFREQ/speedstep and some ACPI related
> things on Intel 955X chipset I have. So I use a ASUS P5WD2-Premium.
> The Pentium D will reach me in few days so I only guess and  I think the
> kernel know how to handle Physical Cores and SMT/HT Processors.
> 
> 
>>The specs indicate that 64 bit is supported, is there any actualy
>>Linux support for the Intel 64 bit stuff in gcc and the kernel? One of
>>the people I work with reports that the distro he runs on his Athlon64
>>lock solid after reading the boot sector, so obviously this isn't
>>Athlon compatable.
>>
> 
> Yes the 64bit support of the Intel CPUs are well supported, I use a
> Intel Pentium 4 640 and 64bit compiled system (Gentoo 2005)
> I have no problems everything is working nearly perfect better as my
> AMD64 system.
> 
> For GCC 3.4.x or 4.0.x you only need the compile switch -march=nocona as
> the name of the XEON..but its the same piece of technologie

Okay, unless I can find an Intel-64 build of Fedora I'll have to do it 
myself, but now that I know what option to use it's possible. Trust 
Intel to have a 64 bit standard which isn't Itanium and isn't ..quite.. 
AMD compatible.
> 
> 
>>The price is lower than a dual Xeon setup if you have an application
>>which needs SMP, and initial power values make it look like a lower
>>power solution overall.
> 
> 
> Cheep and good performance.

Thanks for the pointer!
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
