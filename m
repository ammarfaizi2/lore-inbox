Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSJQRwQ>; Thu, 17 Oct 2002 13:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262039AbSJQRwQ>; Thu, 17 Oct 2002 13:52:16 -0400
Received: from fep02.tuttopmi.it ([212.131.248.101]:46282 "EHLO
	fep02-svc.flexmail.it") by vger.kernel.org with ESMTP
	id <S262038AbSJQRwO> convert rfc822-to-8bit; Thu, 17 Oct 2002 13:52:14 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Frederik Nosi <fredi@e-salute.it>
Reply-To: fredi@e-salute.it
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG][neofb]2.5.4[0-3]
Date: Thu, 17 Oct 2002 20:01:08 +0000
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210172001.08099.fredi@e-salute.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm sending this message to the list becouse mailing you directly bouces)


At first thank you for your reply. 

On Thursday 17 October 2002 16:43, you wrote:
> > I have a DELL Latitude CPi D233SP. With kernels from 2.5.40 to 2.5.43
> > using neofb during shutdown I get an Oops:
> >
> > Danger danger! Oopsen imminent
> > MTRR setting reg 2
> >
> > This is the second time I'm reporting this, the first time I CC'ed the
> > mantainer too without results. Here is the link to my previous posting:
> >
> > http://www.cs.helsinki.fi/linux/linux-kernel/2002-39/1108.html
>
> I saw it but I was busy finsihing the fbdev changes that are about to go
> in. I also have this chipset so I plan to track down the bug now that I
> have finished my work.

Ok, no problem, this dont seems as a serious issue so I can live with that.

>
> > With the 2.4.19/20-pre-last kernels scrolling up in the console is very
> > slow using the neofb driver as I've wrote in my previous posting.
>
> What color depth? Acceleration only works for 8 and 16 bpp modes :-(

I'm booting kernels with the " vga=771"  option. If I remeber well this is 
800x600 with 16bpp. However with this same settings the slowness in scrolling 
up dont happens with the latest 2.5 kernels
If you want more info just drop me a mail.

Cheers,
Frederik Nosi

