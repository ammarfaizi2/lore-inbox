Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271648AbRHUMTY>; Tue, 21 Aug 2001 08:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271645AbRHUMTO>; Tue, 21 Aug 2001 08:19:14 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:51948 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S271648AbRHUMTF>; Tue, 21 Aug 2001 08:19:05 -0400
Date: Tue, 21 Aug 2001 14:19:15 +0200
From: Philip Van Hoof <freax@pandora.be>
To: cwidmer@iiic.ethz.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with SMP on most kernels (apic and "stuck on TLB IPI wait"-error)
Message-ID: <20010821141915.C980@pluisje.pandora.be>
In-Reply-To: <20010821134228.G872@pluisje.pandora.be> <200108211201.f7LC1Hk22450@mail.swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200108211201.f7LC1Hk22450@mail.swissonline.ch>; from cwidmer@iiic.ethz.ch on Tue, Aug 21, 2001 at 14:01:10 +0200
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001.08.21 14:01 Christian Widmer wrote:
> sorry i just saw that you have a via chipset. i didn't realise that 
> your mail continues below the error-msg-list - sorry again.
> that bord you have is know for that problem, i've them too. 
> just be fine with noapic. i don't know it asus fixed there bios 
> with in the latest release. i didn't try since it works with no apic,
> since i live with "never touch a running system - murfy is watching
> you" :)

This is the (latest) BIOS update 
http://www.asus.com.tw/products/Motherboard/bios_s370.html#cuv4x-d
I don't see any information about the VIA694XDP Chipset that I have

I am not very sure about updating this bios. If it would say
"This BIOS update fixes some VIA chipset bugs" then okay but now..
blindly installing a new bios :-\ I don't know..
 
Is there another way to get around this problem ? I don't have
any problems with the fact that I have to use "noapic" but I do have
problems with the fact that at this moment, with a 2.2.x kernel I
get "stuck on TLB IPI wait" errors and on a 2.4.x the system hangs
when switching console to X.


-- 
Philip van Hoof aka freax (http://www.freax.eu.org)
irc: irc.openprojects.net mailto:freax @ pandora.be
