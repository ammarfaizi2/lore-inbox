Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285017AbSADWGn>; Fri, 4 Jan 2002 17:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285022AbSADWGY>; Fri, 4 Jan 2002 17:06:24 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:37639 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id <S285017AbSADWGS>;
	Fri, 4 Jan 2002 17:06:18 -0500
Message-Id: <200201042319.g04NJYL09845@clueserver.org>
Content-Type: text/plain; charset=US-ASCII
From: Alan <alan@clueserver.org>
Reply-To: alan@clueserver.org
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] USB Storage Config patch for 2.4.17 and 2.5.1
Date: Fri, 4 Jan 2002 12:49:45 -0800
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200201041041.g04AfiL05830@clueserver.org> <200201042117.g04LHkL08977@clueserver.org> <20020104214800.GC21034@kroah.com>
In-Reply-To: <20020104214800.GC21034@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 January 2002 13:48, Greg KH wrote:
> On Fri, Jan 04, 2002 at 10:47:57AM -0800, Alan wrote:
> > Here is the patch attached. Tested on 2.4.17 and 2.5.1. (Needs a version
> > for the new 2.5.x config structure, but that should be trivial.)
>
> Thanks, I've applied just a portion of the patch (no need in indenting
> the usb-storage options, see
> http://linuxusb.bitkeeper.com:8088/usb-2.4/patch@1.563?nav=cset@1.563
> and
> http://linuxusb.bitkeeper.com:8088/usb-2.5/patch@1.135?nav=cset@1.135
> for the end result) to my 2.4 and 2.5 trees.  I'll forward them on the
> the proper kernel maintainers.

Cool. Sorry it took so long to get it to you.  Just distracted by other 
things. (The patch was quick. Took less than 15 minutes to create and test. 
Remembering to do it was the hard part. ]:> )

> > BTW, this was written during the PLUG meeting last night. (Which you
> > missed.)
>
> Ah, must have been another boring meeting if you were writing kernel
> config patches during it :)

Actually it was a very good meeting. (Randal Schwartz was speaking on the 
future of Perl.)  I wrote it during the "history of Perl" section, since I 
already knew that part. (Don't ask. A messy story involving mailing list 
maintence over a 28k connection.)  I am waiting to write the security 
exploits for part of it if they actually do some of the things he spoke of in 
Perl 6.  (User modifiable core code. Mmmm!)

Besides, some people only attend the meetings for the beer and/or cider 
afterwards...


