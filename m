Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSIOGkT>; Sun, 15 Sep 2002 02:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317876AbSIOGkS>; Sun, 15 Sep 2002 02:40:18 -0400
Received: from packet.digeo.com ([12.110.80.53]:62597 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S317874AbSIOGjq>;
	Sun, 15 Sep 2002 02:39:46 -0400
Message-ID: <3D843008.1AFA5259@digeo.com>
Date: Sun, 15 Sep 2002 00:00:24 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Daniel Phillips <phillips@arcor.de>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
References: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com> <E17qRfU-0001qz-00@starship> <20020915020739.A22101@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2002 06:44:34.0859 (UTC) FILETIME=[5A7FC7B0:01C25C83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> > From: Daniel Phillips <phillips@arcor.de>
> > Date: Sun, 15 Sep 2002 07:10:00 +0200
> 
> >[...]
> > Let's try a different show of hands: How many users would be happier if
> > they knew that kernel developers are using modern techniques to improve
> > the quality of the kernel?
> 
> I do not see how using a debugger improves a quality of the kernel.
> Good thinking and coding does improve kernel quality. Debugger
> certainly does not help if someone cannot code.
> 
> A debugger can do some good things. Some people argue that it
> improves productivity, which I think may be true under some
> circomstances. If your build system sucks and/or slow, and
> if you work with a binary only software, debugger helps.
> If you work with something like Linux, and compile on something
> better than a 333MHz x86, it probably does not help your
> productivity. This is all wonderful, but has nothing to do
> with the code quality.

Uh, I feel obliged to respond to these statements just in case
anyone thinks they contain anything which is correct.

I have spent twelve months doing kernel development without kgdb and
eighteen months with.  "With" is better.

> And to think that your users would be happier with a crap produced
> by a debugger touting Windows graduate than with a quality code
> debugged with observation simply defies any reason.
> 

uh-huh.
