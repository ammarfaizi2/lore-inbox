Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280597AbRKBITb>; Fri, 2 Nov 2001 03:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280598AbRKBITL>; Fri, 2 Nov 2001 03:19:11 -0500
Received: from [216.234.199.96] ([216.234.199.96]:3603 "EHLO lego.zianet.com")
	by vger.kernel.org with ESMTP id <S280597AbRKBITA>;
	Fri, 2 Nov 2001 03:19:00 -0500
Message-ID: <3BE25511.3080708@zianet.com>
Date: Fri, 02 Nov 2001 01:10:57 -0700
From: Steven Spence <kwijibo@zianet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: emu10k emits buzzing and crackling
In-Reply-To: <20011101200955.A1913@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may want to try the cvs version, but I thought they were pretty close
to being in sync.  I have the same setup as you(dual Athlon, RH7.2) and
I haven't seen any problems as of yet.

Steven

Benjamin LaHaise wrote:

>Hey folks,
>
>One of the workstations I use really doesn't like the emu10k driver in 
>2.4.13-ac5.  The box is a dual athlon running rh7.2.  Playing mp3s seems 
>to work well, but other samples from xfce on shutdown and window close 
>result in buzzing and popping noises.  If anyone wants details or patches 
>tested, drop me a note.
>
>		-ben
>
>es1371: version v0.30 time 17:42:30 Nov  1 2001
>Creative EMU10K1 PCI Audio Driver, version 0.16, 17:42:24 Nov  1 2001
>emu10k1: EMU10K1 rev 7 model 0x8040 found, IO at 0x2400-0x241f, IRQ 19
>ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
>usb.c: registered new driver hub
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>



