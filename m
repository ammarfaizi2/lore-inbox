Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280615AbRKBKHa>; Fri, 2 Nov 2001 05:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280633AbRKBKHU>; Fri, 2 Nov 2001 05:07:20 -0500
Received: from 216.187.152.120.morcant.org ([216.187.152.120]:11957 "EHLO
	mail.morcant.org") by vger.kernel.org with ESMTP id <S280615AbRKBKHK>;
	Fri, 2 Nov 2001 05:07:10 -0500
Message-ID: <32796.24.255.76.12.1004695621.squirrel@webmail.morcant.org>
Date: Fri, 2 Nov 2001 02:07:01 -0800 (PST)
Subject: Re: emu10k emits buzzing and crackling
From: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>
To: kwijibo@zianet.com
In-Reply-To: <3BE25511.3080708@zianet.com>
In-Reply-To: <3BE25511.3080708@zianet.com>
Cc: bcrl@redhat.com, linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You may want to try the cvs version, but I thought they were pretty close to being in
> sync.  I have the same setup as you(dual Athlon, RH7.2) and I haven't seen any
> problems as of yet.
> 
> Steven
> 
> Benjamin LaHaise wrote:
> 
>>Hey folks,
>>
>>One of the workstations I use really doesn't like the emu10k driver in  2.4.13-ac5. 
>>The box is a dual athlon running rh7.2.  Playing mp3s seems  to work well, but other
>>samples from xfce on shutdown and window close  result in buzzing and popping noises.
>> If anyone wants details or patches  tested, drop me a note.
>>
>>
	-ben
>>
>>es1371: version v0.30 time 17:42:30 Nov  1 2001
>>Creative EMU10K1 PCI Audio Driver, version 0.16, 17:42:24 Nov  1 2001 emu10k1:
>>EMU10K1 rev 7 model 0x8040 found, IO at 0x2400-0x241f, IRQ 19 ac97_codec: AC97 Audio
>>codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23) usb.c: registered new driver hub
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in the body
>>of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html Please read the
>>FAQ at  http://www.tux.org/lkml/
>>
I've also experianced this with 2.4.13+preempt. As ben said, playing single large files
works fine, but when playing short files or using esd for short bursts of sound, I often
get popping noises.

I'll give the cvs version a try and report back.

-- 
Morgan Collins [Ax0n] http://sirmorcant.morcant.org
Software is something like a machine, and something like mathematics, and something like
language, and something like thought, and art, and information.... but software is not in
fact any of those other things.

