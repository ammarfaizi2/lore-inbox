Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270739AbUJUOrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270739AbUJUOrc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270711AbUJUOol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:44:41 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:28424 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S270728AbUJUOje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:39:34 -0400
Message-ID: <4177CCE5.60904@techsource.com>
Date: Thu, 21 Oct 2004 10:51:17 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Jim Nelson <james4765@verizon.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <4176E671.4090104@verizon.net>
In-Reply-To: <4176E671.4090104@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jim Nelson wrote:
> Timothy Miller wrote:
> 
>> I can produce more detail later, but first, some characteristics and 
>> advantages of what I'm proposing:
>>
>> - x86 BIOS/OpenBoot/OpenFirmware code under BSD and GPL license
>> - kernel drivers under BSD and GPL license
>> - X11 module under MIT license
>> - flashable PROM so that boot code can be added for more platforms
>> - usable as the console on any platform that can take a PCI, AGP, or 
>> PCI-Express card
>> - downloadable schematic for the circuit board
>> - FPGA-based graphics engine so it's reprogrammable
>> - instructions on how to reprogram the FPGA, so it's hackable
>> - if we discontinue a product, we may release the Verilog code for the 
>> FPGA
>> - Since this is designed to be open-source-friendly, we want to play 
>> by the rules of the open-source community.
>> - Tech Source would actively participate in the development and 
>> maintenance of our own drivers.
>> - We will actually pay attention to problems and concerns raised by 
>> users and developers.
>> - We won't be control-freaks.
> 
> 
>> I haven't worked out a complete design spec for this product.  The 
>> reason is that what we think people want and what people REALLY want 
>> may not be congruent.  If you have a good idea for a piece of graphics 
>> hardware which you think would be beneficial to the free software 
>> community (and worth it for a company to produce), then Tech Source, 
>> as a graphics company, might be willing to sell it.
>>
>>
> 
> You might want to take a look at the onboard video market.  Providing an 
> open-source 2D rendering engine and the PCI glue logic that work on an 
> FPGA would probably revolutionize embedded PC applicatiuons that rely on 
> a graphical interface.  Providing support to motherboard manufaturers 
> who might want a low-cost onboard video solution (micro-ITX, etc) is 
> another possibility.

Now, THIS is an excellent idea.  If the volumes there would be high 
enough, it could be what justifies the project.  We have had customers 
wanting embedded solutions, and through this project, we could provide 
them something even better in the future.

> You also might want to look at PC/104 and CompactPCI form factors - I 
> think the industrial market will be a great target, and, after all, if 
> you have to move 80% industrial equipment to justify the 20% AGP sales, 
> it makes good sense.  There might even be a market for ISA, SBus, and 
> MCA cards, for people stuck supporting seriously old machines (386, 486, 
> SPARC) where it's almost impossible to find working graphics cards. Even 
> if it's a DOS machine, hardware is hardware, and a brand-new VL-bus card 
> for someone's 486 would be pretty cool :)

This is a good idea too.  I've already decided to try to fit it onto a 
1/2 height, short PCI card (like the low-end 3ware cards) so that you 
can put the card into one of these compact cases.

At this time, I'm not sure it's worth it to do anything other than PCI, 
AGP, and PCIE, however.  Of course, if someone comes along with a large 
enough order, we'd be plenty willing to do whatever customization they want.

Force of will isn't going to get this project done.  Money is what 
matters here.  <sigh>  :)

