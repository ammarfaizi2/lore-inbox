Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbTAJPMF>; Fri, 10 Jan 2003 10:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbTAJPMF>; Fri, 10 Jan 2003 10:12:05 -0500
Received: from mail.sevencubes.de ([62.245.134.131]:61575 "HELO
	wwwserver1.sevencubes.de") by vger.kernel.org with SMTP
	id <S265154AbTAJPME> convert rfc822-to-8bit; Fri, 10 Jan 2003 10:12:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
Organization: Entracom GmbH
To: Oleg Drokin <green@namesys.com>
Subject: Re: Severe reiserfs problems
Date: Fri, 10 Jan 2003 16:20:42 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200301101332.50873.robert.szentmihalyi@entracom.de> <20030110172115.A9028@namesys.com>
In-Reply-To: <20030110172115.A9028@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301101620.42248.robert.szentmihalyi@entracom.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 January 2003 15:21, Oleg Drokin wrote:
> Hello!

Hi Oleg,

>
> On Fri, Jan 10, 2003 at 01:32:50PM +0100, Robert Szentmihalyi wrote:
> > I have severe file system problems on a reiserfs partition.
> > When I try copy files to another filesystem, the kernel panics at
> > certain files.
>
> Can you tell us what the panics were?
> What was the kernel version?

It said "... killing interrupt handler!"
However, the message is not exactly reproduceable. 
Meanwhile, when I mount the partition in the rescue system (SuSE Linux 
8.1) and access the mountpoint somehow, the machine reboots...

>
> > reiserfsck --fix-fixable says that I need to run
> > reiserfsck --rebuild-tree to fix the errors, but when I do this,
> > reiserfsck hangs after a few secounds.
>
> What's the reiserfsck version you have?

I have tried tried SuSE 8.0 and 81 rescue systems with kernels 2.4.18.and 
2.4.19 / reiserfsck 3.x.1b and 3.6.2 with the same result.

> What do you mean by hangs? Does it eats cpu time or something?

It just freezes doesn't react to key presses no more.
All you can do is swith the computer off... 

>
> > Is there a way to rescue at least some of the data on the partition?
>
> There is not enough info yet to know the answer.

I am happy to provide any inforamation you might need.

>
> Bye,
>     Oleg

Thanks for your help so far,
 Robert

-- 
Where do you want to be tomorrow?

Entracom. Building Linux systems.
http://www.entracom.de

