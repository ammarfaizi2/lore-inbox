Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281811AbRLLTa7>; Wed, 12 Dec 2001 14:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281817AbRLLTau>; Wed, 12 Dec 2001 14:30:50 -0500
Received: from ns.crrstv.net ([216.94.219.4]:54427 "EHLO mail.crrstv.net")
	by vger.kernel.org with ESMTP id <S281811AbRLLTah>;
	Wed, 12 Dec 2001 14:30:37 -0500
Date: Wed, 12 Dec 2001 15:19:36 -0400 (AST)
From: skidley <skidley@crrstv.net>
X-X-Sender: <skidley@localhost.localdomain>
To: Stefan Reinauer <stepan@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] SuSe kernel
In-Reply-To: <20011212120117.A29895@suse.de>
Message-ID: <Pine.LNX.4.33L2.0112121518090.4304-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, Stefan Reinauer wrote:

> * Samuel Maftoul <maftoul@esrf.fr> [011211 19:30]:
> > In SuSe's kernel there is a nice feature but I cannot  found where is
> > the code that does it and so I cannot play with it 8-).
> > The thing I'm talking about is grpahical boot + graphical first console.
> > I glanced at include/asm-i386/linux_logo.h but it doesn't differ.
> > Can someone help me ?
> >         Sam
>
> The boot splash patch I made for SuSE allows you to use any jpg picture
> as a background console. You can define the text area freely on this
> picture.
>
> Have a look at http://www.suse.de/~stepan/bootsplash/ to find the latest
> patches. Currently they only apply against a kernel already patched with
> bootlogo version patch by Gerard Sharp <gsharp@ihug.co.nz> (this patch can
> be downloaded from above location, too)
>
> Any ideas/bug reports are welcome!
>
> Best regards,
>   Stefan Reinauer
>
>
Where do i put the bootaplash.cfg?
-- 
  .-.                               .-.
  oo|  Give Microsoft The Bird!!!!  oo|
 /`'\  Use Linux!!!                /`'\
(\_;/)                            (\_;/)
-----------------------------------------------------
"Software is like sex: It's better when it's free."
           --- Linus Torvalds

Chad Young
Registered Linux User #195191 @ http://counter.li.org

