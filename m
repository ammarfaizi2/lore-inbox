Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265218AbRF0JIY>; Wed, 27 Jun 2001 05:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbRF0JIO>; Wed, 27 Jun 2001 05:08:14 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:50354 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S265218AbRF0JH5> convert rfc822-to-8bit;
	Wed, 27 Jun 2001 05:07:57 -0400
Message-ID: <3B39A269.4C7E60@Sun.COM>
Date: Wed, 27 Jun 2001 11:07:53 +0200
From: Julien Laganier <Julien.Laganier@Sun.COM>
Organization: Sun Microsystems
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: John Nilsson <pzycrow@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Some experience of linux on a Laptop
In-Reply-To: <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Nilsson wrote:
> 
> Well I thought that it was time for me to give some feedback to the linux
> community. So I will tell you guys a little of my experience with linux so
> far.
> 
> I have a Toshiba Portégé 3010CT laptop. That is:
> 266MHz Pentium-MMX
> 4GB HD with 512kb cache (which linux reduces to 0kb)
> 32 Mb EDO RAM
> 
> After have tried
> Slackware
> Gentoo
> Linux From Scratch
> Debian
> Mandrake
> and soon ROCK linux
> 
> I have come to the conclusion that linux is NOT suitable for the general
> desktop market, I have configured a number of linux routers/fierwalls and am
> really pleased with the scalability, but the harware compatibility is to
> damn low for a general user base. I know this isn't really a Linux issue
> rather a distribution issue, but in the end it's you guys that make the
> drivers. So a little plea is that you let the optimization phase cooldown a
> little and concern your self a little more with compatibility, and ease of
> installation, (tidy up the kernel build system).
> 
> On my particular computer the chipset (toshiba specific) is not supported
> wich makes the harddrive unable to run in UDMA and/or use it's cache.
> Somehow this make X totaly unusable. With a little luck if it doesn't hang
> it takes several minutes to launch a simple program.
> This could be X specific, but I doub't it.
> 
> So when you speak of being able to run on 386:es I still have problem
> starting X on 266MHz with 32Mb mem. This should not be =)

Take a look at http://www.linux-laptop.net
It's quite useful :-)
