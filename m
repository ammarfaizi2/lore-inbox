Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276689AbRJBVGc>; Tue, 2 Oct 2001 17:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276693AbRJBVGX>; Tue, 2 Oct 2001 17:06:23 -0400
Received: from mailc.telia.com ([194.22.190.4]:22233 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S276689AbRJBVGI>;
	Tue, 2 Oct 2001 17:06:08 -0400
Message-ID: <3BBA2C54.772BA971@canit.se>
Date: Tue, 02 Oct 2001 23:06:28 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: System reset on Kernel 2.4.10
In-Reply-To: <Pine.LNX.4.33.0110022110070.21544-100000@vela.salleURL.edu>
	 <3BBA1409.6AAA553D@welho.com> <1091577748.20011002230931@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VDA wrote:

> Tuesday, October 02, 2001, 9:22:49 PM,
> Mika Liljeberg <Mika.Liljeberg@welho.com> wrote:
>
> ML> Carles Pina i Estany wrote:
> >> The Kernel works fine. But for error I execute /usr/src/linux/vmlinux as
> >> root user. Then the system is rebooted (without unmounting anything)
> >>
> >> Curious.
>
> ML> And like a headstrong child, I refused to believe, instead thrusting my
> ML> finger into the fire.
> ML> Ouch! Curious indeed.
>
> Come on guys, that can't be true! Linux can't fail that miserably!
> Look:
>
> # su user
> $ ./vmlinux
> Segmentation fault
> *** screen went blank, then POST screen appears ***
>
> Eh... Oh... So... it actually can.   8-(
>

I installed reiserfs this weekend so I tried it and yes me to :))

I have another one that happens with stuff that use SDL (loki stuff) but then
the computer turns off like I had pressed the power button. So  I can use both
shutdown -h or plaympeg to turn the computer off :)


