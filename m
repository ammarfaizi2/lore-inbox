Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271899AbRIIFOH>; Sun, 9 Sep 2001 01:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271903AbRIIFN5>; Sun, 9 Sep 2001 01:13:57 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:20229 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S271899AbRIIFNl>; Sun, 9 Sep 2001 01:13:41 -0400
Date: Sun, 9 Sep 2001 10:44:33 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: kernelnewbies <kernelnewbies@nl.linux.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Reg lilo.conf changed and system doesn't boot
In-Reply-To: <3B994BEC.F418F342@didntduck.org>
Message-ID: <Pine.LNX.4.10.10109091043110.4648-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks fot the suggestion.
I tried that but it panics. Will I be able to change anything inside the
boot floppy after it has been made with 2.2.6 kernel so that I can boot
2.2.14. 

Warm regs,
sathish

On Fri, 7 Sep 2001, Brian Gerst wrote:

> "SATHISH.J" wrote:
> > 
> > Hi,
> > I know that this is not the place to ask this question.Please forgive me.
> > I changed the lilo.conf on my machine(redhat 2.2.14-12 kernel) and it
> > doesn't boot up. I don't have
> > a boot floppy to boot. I have another disk which has an older version of
> > linux(2.2.6). I can mount the disk if I boot from the other
> > disk(2.2.6). Can I
> > in some way alter the lilo.conf of my disk(2.2.14) and boot linux from
> > that. Please tell me any ideas to do that.
> 
> Boot your 2.2.6 disk, and make a boot floppy from that.  Put in the
> original disk and boot from the floppy.  Check your lilo.conf and rerun
> lilo.
> 
> -- 
> 
> 						Brian Gerst
> 

