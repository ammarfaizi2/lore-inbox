Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945902AbWANBB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945902AbWANBB1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945909AbWANBB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:01:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54289 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945902AbWANBB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:01:27 -0500
Date: Sat, 14 Jan 2006 02:01:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Philippe Delodder <lodder@delodder.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug
Message-ID: <20060114010126.GU29663@stusta.de>
References: <3096.80.200.243.137.1137079435.squirrel@mail.delodder.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3096.80.200.243.137.1137079435.squirrel@mail.delodder.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 04:23:55PM +0100, Philippe Delodder wrote:
> ------------[ cut here ]------------
> kernel BUG at lib/radix-tree.c:271!
> invalid operand: 0000 [#1]
> PREEMPT
> Modules linked in: af_packet ipv6 floppy analog parport_pc parport evdev
> pcspkr 8139cp snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_pcm snd_timer
> snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd
> hw_random pci_hotplug intel_agp uhci_hcd usbcore i810_audio ac97_codec
> soundcore 8139too mii agpgart quota_v2 ext3 jbd capability commoncap
> psmouse ide_cd cdrom rtc reiserfs ide_generic ide_disk piix ide_core unix
> font vesafb cfbcopyarea cfbimgblt cfbfillrect
> CPU:    0
> EIP:    0060:[<c018d02e>]    Not tainted
> EFLAGS: 00010096   (2.6.8-2-386)
>...

2.6.8 is a very ancient kernel.

Please either try to reproduce it with a vanilla ftp.kernel.org 2.6.15 
or contact your vendor (Debian?) regarding this issue.

> Philippe Delodder

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

