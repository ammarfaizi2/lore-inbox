Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbRAWKDk>; Tue, 23 Jan 2001 05:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130092AbRAWKDU>; Tue, 23 Jan 2001 05:03:20 -0500
Received: from mail.digitalme.com ([193.97.97.75]:17673 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S129601AbRAWKDR>;
	Tue, 23 Jan 2001 05:03:17 -0500
Message-ID: <3A6D56EE.2070003@bigfoot.com>
Date: Tue, 23 Jan 2001 05:03:26 -0500
From: "Trever L. Adams" <trever_Adams@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010119
X-Accept-Language: en
MIME-Version: 1.0
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
CC: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Total loss with 2.4.0 (release)
In-Reply-To: <Pine.LNX.4.32.0101230026490.7610-100000@asdf.capslock.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike A. Harris wrote:

> On Mon, 15 Jan 2001, Trever Adams wrote:
> 
> I don't see how Windows 9x can be at fault in any way shape or
> form, if you can boot between 2.2.x kernel and 9x no problem, but
> lose your disk if you boot Win98 and then 2.3.x/2.4.x and lose
> everything.  Windows does not touch your Linux fs's, so if there
> is a problem, it most likely is a kernel bug of some kind that
> doesn't initialize something properly.

Well, I boot into Linux, all is fine, rebooted into a different version 
of Linux for some testing, all is fine (this was an older version, I 
believe it was 2.2.14 or .15)  Try to install ME and run it, seems ok. 
Go back to Linux, and my drive was fried with Windows files all over it, 
etc.

I know Windows shouldn't touch a Linux partition.  But, apparently it 
did.  Or else Linux and/or Fdisk are fried and made a bad partition table.

> Windows sucks, and I hate it as much (probably more) than the
> next guy.  It's not fair to blame every computer problem on it
> though unless you KNOW that Windows directly caused the problem.

I said what I did, because it seems the evidence said Windows did do it. 
  If it didn't, oops.  I have talked with others and they had a similar 
experience, so I am not alone.

> Pick one of the 1000000000 good reasons to say Windows sucks
> instead...
> 
> For what it is worth, I have a similar problem where if I boot
> Windows (to show people what "multicrashing" is), if I boot back
> into Linux, my network card no longer works (via-rhine).  Most
> definitely a Linux bug.  In this case, "via-rhine.o" sucks.
> 
> ;o)

Well, this is actually the second time I have had Windows write all over 
my Linux partition.  The first time I think it was not a bug in either, 
but a bug in hardware.  However, I no longer have that hardware as my 
desktop.

Trever

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
