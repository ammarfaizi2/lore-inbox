Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130479AbRBILWp>; Fri, 9 Feb 2001 06:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130411AbRBILWf>; Fri, 9 Feb 2001 06:22:35 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:63728 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S130479AbRBILWY>;
	Fri, 9 Feb 2001 06:22:24 -0500
Message-ID: <6D1A8E7871B9D211B3B00008C7490AA5645311@treis03nok>
From: Patrick.Stickler@nokia.com
To: vido@ldh.org
Cc: linux-kernel@vger.kernel.org
Subject: RE: Kernel panics on C1VN and RH 6.2 or 7.0
Date: Fri, 9 Feb 2001 13:22:16 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
The BIOS settings don't seem to offer that option.

Is it possible to tell the kernel where that hole is
via a bootprompt argument?

Thanks,

Patrick

patrick.stickler@nokia.com

-----Original Message-----
From: ext Augustin Vidovic
To: Patrick.Stickler@nokia.com
Sent: 2/9/01 1:18 PM
Subject: Re: Kernel panics on C1VN and RH 6.2 or 7.0

Try to disable the "memory hole at 16 Mb" if it's activated in
your BIOS settings.

On Fri, Feb 09, 2001 at 01:10:48PM +0200, Patrick.Stickler@nokia.com
wrote:
> 
> Hi, 
> 
> I'm trying to install RH Linux on my C1VN and am getting
> some strange behavior that doesn't correspond to any of the
> various HOWTO's etc. on putting Linux on the C1VN.
> 
> I'm wondering if the amount of RAM matters (I have 192MB,
> the others all seem to have 128MB) or maybe I have one
> of the broken CPU's.
> 
> No matter whether I try to install 6.2 or 7.0, via CD-ROM
> or network, somewhere during the install (at random places)
> I get a kernel panic with an error message such as:
> 
>    Unable to handle kernel paging request at virtual address ...
> 
> I've also gotten a few Oops: messages.
> 
> I had the default BIOS settings, but also tried turning off
> plug and play, as I'd seen mention elsewhere that that was
> problemmatic with the ANSA sound drivers, but no difference.
> 
> This is particularly puzzling as there seem to be lots of
> folks who have had no problems putting the stock RH 6.2 or
> 7.0 dists on their C1VN's. I've tried different media and
> over the network, so it's not that I have a corrupt dist.
> Very odd...
> 
> I'm hoping that one of you kernel guru's who has a C1VN
> (terve Linus ;-) might have a clue why mine seems to behave
> differently than everyone elses...  Maybe it's just the cold
> weather ;-)
> 
> Thanks in advance,
> 
> Patrick Stickler
> Nokia Networks
> Tampere, Finland
> 
> patrick.stickler@nokia.com
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
