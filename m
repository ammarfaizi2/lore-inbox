Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263188AbUDYSPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbUDYSPc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 14:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbUDYSPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 14:15:32 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:50317 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S263188AbUDYSP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 14:15:29 -0400
Date: Sun, 25 Apr 2004 11:15:28 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: carloschoenberg@yahoo.com
cc: linux-kernel@vger.kernel.org
Subject: Re: well-supported motherboard 
In-Reply-To: <S263174AbUDYRbv/20040425173151Z+1925@vger.kernel.org>
Message-ID: <Pine.LNX.4.44.0404251042590.13391-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Apr 2004 carloschoenberg@yahoo.com wrote:

> I am looking for a motherboard that is known to work well with Linux.
> "Known to work well" means:
> 1) working open source drivers exist for all onboard components
> 2) most people are not experiencing random crashes or data corruption,
> or the reason for such is understood and a proper fix exists.
> 3) multiple people are using the board successfully
> 4) no VIA northbridge/southbridge, though other VIA components might
> be OK.  Although there are people successfully using VIA chipsets, I
> do not believe that VIA considers the stability of their products to
> be an important concern.

notwithstanding any previous issues we've had I've found our via k8t800 
chipset mainboards (amd64 cpus) to be very stable. the one we use for 
desktop machines is the msi kt8 neo fisr and we been very happy with the 
hardware support in modern distros for these boards. 
                                                                                 
> It seems that no one does proper testing of motherboards with Linux.
> Although I can find reviews that put a variety of boards through a
> handful of tests in Windows, I can't find any reviews that properly
> test Linux.

Both supermicro and tyan do fairly extensive testing of their server and 
workstation product lines with linux. If you think there's a lot of dual 
itanium II's and 4-way opterons out there running windows you'd be wrong. 
They both make boards that ought to be pretty attractive to building 
single cpu desktops boxes such as the supermicro p4sct+II (intel 875p) or 
the tyan Tiger K8WS (amd chipset)
                                                                                 
> I had preferred AMD CPUs, but if my choices for motherboards are VIA
> and nforce2 (random crashing) chipsets, it looks like I will have to
> go with P4.
>                                                                                 
> My other requirements/desires are:
> 1) AGP 8X (this is the only hard requirement for features)
> 2) Dual ethernet
> 3) lots of USB2.0
> 4) firewire
> 5) four IDE controllers
> 6) audio with SPDIF out that will not resample 44100khz output (I'm not
> sure if this exists).

I'd look at the msi 875P NEO-FIS2R for p4, the K8T_Neo-FIS2R for athlon64 
and the tyan thunder K8W or ws for an opteron solution. given how cheap 
pci ethernets are you shouldn't be concerned about that most workstation 
boards don't come with two.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu    
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2


