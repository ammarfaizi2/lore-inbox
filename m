Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269951AbRHEM4B>; Sun, 5 Aug 2001 08:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269952AbRHEMzv>; Sun, 5 Aug 2001 08:55:51 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:24467 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S269951AbRHEMzc>; Sun, 5 Aug 2001 08:55:32 -0400
Date: Sun, 5 Aug 2001 14:55:18 +0200
From: Cliff Albert <cliff@oisec.net>
To: Vieri Di Paola <vieridipaola@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 128M
Message-ID: <20010805145518.A23485@oisec.net>
In-Reply-To: <20010805115418.28773.qmail@web4902.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010805115418.28773.qmail@web4902.mail.yahoo.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2001 at 04:54:18AM -0700, Vieri Di Paola wrote:
> I just bought a DIMM 128M RAM module and inserted it
> in the motherboard. I took the old 2x8M SIMM modules.
> However, my BIOS sees only 32M. I read though that I
> can pass the kernel the argument "mem=128m" and Linux
> should use all the available RAM. But this operation
> leads to an error: "protection fault" and the boot
> halts. Could there be a hardware problem with the DIMM
> card? Or is just a BIOS thing, in which case there's
> isn't anything I can do, or is there? I tried SuSE 6.3
> and BestLinux Release 3 with both lilo and grub. I
> passed kernel ... vmlinuz mem=128m but boot fails.
> However any mem value below 32m works and the command
> "top" shows the correct amount of memory.

It's your motherboard that can't cope with the DIMM. The only                                                          
dimm's it probably will support are 32MB DIMM's. All other                                                             
(bigger) DIMMs wil not work.     

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
