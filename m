Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbTEFNWo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbTEFNWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:22:44 -0400
Received: from lakemtao03.cox.net ([68.1.17.242]:45781 "EHLO
	lakemtao03.cox.net") by vger.kernel.org with ESMTP id S263687AbTEFNWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:22:43 -0400
Message-ID: <3EB7BA01.2000206@cox.net>
Date: Tue, 06 May 2003 08:34:57 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.69] Fails on "Uncompressing Kernel" (detailed)
References: <3EB7B578.4000005@cox.net>
In-Reply-To: <3EB7B578.4000005@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David van Hoose wrote:
> I've managed to get 2.5.69 to boot *once*. Not trusting the kernel to 
> report the numerous problems until I can boot the kernel more than once. 
> I lost my config so I can't figure out what I managed to do so right. I 
> have tried a couple other configs that I normally use for 2.4.x, but 
> with the new 2.5.x options. Those I have attached.
> All I get is the "Uncompressing Linux" and then no more output. However, 
> it appears that my system is booting anyway as if it is on another TTY. 
> I can even tell when kudzu kicks in. I have no input (keyboard/mouse) or 
> output (monitor) though.
> 
> Hardware:
> Northwood Pentium 4 2.53GHz
> Motherboard is an Asus P4S8X
>  SiS648 Northbridge / SiS963 Southbridge
> nVidia GeForce2 MX 400
> 
> Software:
> RedHat 9 w/ all updates
> Using Rusty's module-init-tools-0.9.12-pre1
> Kernel 2.5.69 as stated
> 
> How can I get this beast to boot?

Running GRUB 0.93 as released by RedHat. I just got the messages for the 
other thread. I've gotten it to boot once, so I don't think it is Grub.

Thanks,
David

