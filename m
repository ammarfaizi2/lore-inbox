Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbTBTTYg>; Thu, 20 Feb 2003 14:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266749AbTBTTYg>; Thu, 20 Feb 2003 14:24:36 -0500
Received: from 251.017.dsl.syd.iprimus.net.au ([210.50.55.251]:59015 "EHLO
	file1.syd.nuix.com.au") by vger.kernel.org with ESMTP
	id <S266622AbTBTTYe> convert rfc822-to-8bit; Thu, 20 Feb 2003 14:24:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Song Zhao <song.zhao@nuix.com.au>
Reply-To: song.zhao@nuix.com.au
Organization: Nuix
To: Bruce Harada <bharada@coral.ocn.ne.jp>
Subject: Re: Supermicro X5DL8-GG (ServerWorks Grandchampion LE chipset) slow
Date: Fri, 21 Feb 2003 06:34:04 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200302202034.28676.song.zhao@nuix.com.au> <200302202201.15977.song.zhao@nuix.com.au> <20030220215128.0c77c98e.bharada@coral.ocn.ne.jp>
In-Reply-To: <20030220215128.0c77c98e.bharada@coral.ocn.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302210634.04566.song.zhao@nuix.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003 07:51 am, Bruce Harada wrote:
> On Thu, 20 Feb 2003 22:01:15 -0500
>
> Song Zhao <song.zhao@nuix.com.au> wrote:
> > > > Also, this board can't even boot with 8x 1GB memory modules plugged
> > > > in (8 DIMM slots in total). This is a relative new board and I can't
> > > > find anything relevant on the net.
> > >
> > > "can't boot" as in crashes halfway during linux or doesn't even start
> > > lilo?
> >
> > It doesn't even start Lilo, it hangs after it checks memory, 3ware card
> > and network card.
>
> In that case, it has nothing to do with Linux... Have you checked to see if
> there's any BIOS updates?

I haven't checked for BIOS updates yet, we were planning to try a different 
brand of memory modules. The chipset is supposed to be able to support up to 
16GB. 8GB should definitely be supported by the default BIOS revision. I put 
4GB in it, and it boots up fine. 

Also, this has nothing to do with the fact that it runs slow when its up and 
running with 4GB. 
