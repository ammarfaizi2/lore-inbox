Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316158AbSFETrT>; Wed, 5 Jun 2002 15:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316167AbSFETrS>; Wed, 5 Jun 2002 15:47:18 -0400
Received: from web14906.mail.yahoo.com ([216.136.225.58]:40197 "HELO
	web14906.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316158AbSFETrQ>; Wed, 5 Jun 2002 15:47:16 -0400
Message-ID: <20020605194716.4290.qmail@web14906.mail.yahoo.com>
Date: Wed, 5 Jun 2002 15:47:16 -0400 (EDT)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: Re: Load kernel module automatically
To: markh@compro.net
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <3CFD19D1.5768FCF8@compro.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've read the man page of modules.conf. But I
still couldn't figure out how to solve my problem. I
mean how to change the modules.conf file. Can I edit
this file directly? Can anyone give me an example?

Thanks.


--- Mark Hounschell <markh@compro.net> wrote:
> Michael Zhu wrote:
> > 
> > Hi, I built a kernel module. I can load it into
> the
> > kernle using insmod command. But each time when I
> > reboot my computer I couldn't find it any more. I
> mean
> > I need to use the insmod to load the module each
> time
> > I reboot the computer. How can I modify the
> > configuration so that the Linux OS can load my
> module
> > automatically during reboot? I need to copy my
> module
> > to the following directory?
> >   /lib/modules/2.4.7-10/
> > 
> > I've done that. But it doesn't work.
> > 
> > Any help will be appreciated.
> 
> $man modules.conf
> 
> Mark


______________________________________________________________________ 
Movies, Music, Sports, Games! http://entertainment.yahoo.ca
