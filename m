Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSEVOdM>; Wed, 22 May 2002 10:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSEVOdK>; Wed, 22 May 2002 10:33:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10695 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314596AbSEVOdJ>;
	Wed, 22 May 2002 10:33:09 -0400
Date: Wed, 22 May 2002 10:33:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <3CEB9943.5030400@evision-ventures.com>
Message-ID: <Pine.GSO.4.21.0205221030100.2737-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Martin Dalecki wrote:

> > For kbdrate???  sysctl I might see - after all, we are talking about
> > setting two numbers.  ioctl() to pass a couple of integers to the kernel?
> > No, thanks.

If you are complaining about use of /dev/port - I completely agree that it's
crap...
 
> Portable along architectures - no thanks?
> Portbale along different devices and device driver implementations - no thanks?
> Not to mess with hardware with preassumtptions how it works - no thanks?
> Giving PC vendors a chance to get rid of silly legacy hardware - no thanks?
> Abviously documented by beeing there - no thanks?

... but WTF does it have to ioctl vs. saner mechanisms?



