Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271007AbRICBil>; Sun, 2 Sep 2001 21:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271019AbRICBib>; Sun, 2 Sep 2001 21:38:31 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:20637 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S271007AbRICBiT>; Sun, 2 Sep 2001 21:38:19 -0400
Date: Sun, 2 Sep 2001 21:38:32 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: pvr2fb.c
In-Reply-To: <E15dh74-0000d0-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0109022133470.23852-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2001, Alan Cox wrote:
>> PS: Compiling 2.4.9 on an Alpha is turning up all manner of weird stuff.  Like
>>     a lot of drivers that aren't 64bit clean, missing parts of asm-alpha...
>
>Linus should have the main missing bits of asm-alpha in 2.4.10pre - although
>on x86 that crashes rapidly for me.

No one said mine was bootable either :-)  It builds.  Booting has yet to be
tested (must fix dinner first.)

The things I go through for my "neat toys" (firewire on an alpha)  On a side
note, the Alpha BIOS Emulation (tm) isn't exactly perfect... the Mylex RAID
configuration stuff won't run -- I know I'm asking alot *grin*  I'll try it
with the DPT (I20) controller in a while. (It ain't easy putting cards in
my alpha.  I've bled on it a few times in the process already.)

--Ricky


