Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbTAJPSY>; Fri, 10 Jan 2003 10:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbTAJPSY>; Fri, 10 Jan 2003 10:18:24 -0500
Received: from angband.namesys.com ([212.16.7.85]:20933 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265169AbTAJPSX>; Fri, 10 Jan 2003 10:18:23 -0500
Date: Fri, 10 Jan 2003 18:27:01 +0300
From: Oleg Drokin <green@namesys.com>
To: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Severe reiserfs problems
Message-ID: <20030110182701.A26101@namesys.com>
References: <200301101332.50873.robert.szentmihalyi@entracom.de> <20030110172115.A9028@namesys.com> <200301101620.42248.robert.szentmihalyi@entracom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200301101620.42248.robert.szentmihalyi@entracom.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jan 10, 2003 at 04:20:42PM +0100, Robert Szentmihalyi wrote:
> > > reiserfsck --fix-fixable says that I need to run
> > > reiserfsck --rebuild-tree to fix the errors, but when I do this,
> > > reiserfsck hangs after a few secounds.
> > What's the reiserfsck version you have?
> I have tried tried SuSE 8.0 and 81 rescue systems with kernels 2.4.18.and 
> 2.4.19 / reiserfsck 3.x.1b and 3.6.2 with the same result.
> > What do you mean by hangs? Does it eats cpu time or something?
> It just freezes doesn't react to key presses no more.
> All you can do is swith the computer off... 

Hm, sounds like you have some hardware problems then.
May be try plugging this hard drive in another system and see what will happen?

Bye,
    Oleg
