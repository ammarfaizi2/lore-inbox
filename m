Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269242AbUJFMvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269242AbUJFMvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 08:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269255AbUJFMvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 08:51:16 -0400
Received: from web41015.mail.yahoo.com ([66.218.93.14]:48310 "HELO
	web41015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269242AbUJFMvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 08:51:09 -0400
Message-ID: <20041006125108.14261.qmail@web41015.mail.yahoo.com>
Date: Wed, 6 Oct 2004 05:51:08 -0700 (PDT)
From: John Carlson <carlsj@yahoo.com>
Subject: Re: Converting kernel modules from 2.4 to 2.6/Suggested new driver
To: crash77a@allvantage.com, "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41636E72.7090103@allvantage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Kenny Bentley <crash77a@allvantage.com> wrote:

> Randy.Dunlap wrote:
> 
> >| Does anyone know if there is a detailed guide on
> how to convert kernel 
> >| modules for 2.4 kernels to modules for 2.6
> kernels?  I know very little 
> >
> >http://lwn.net/Articles/driver-porting/
> >  
> >
> I haven't had a chance to look at it in detail yet,
> but I think that 
> should definitely cover it.  Thanks a lot.
> 
> >OSS is deprecated.  It needs an ALSA driver.
> >  
> >
> That's one reason they made it open-source.  They're
> hoping someone can 
> write an ALSA driver for it.
> 
> >You can recommend them for inclusion, but the
> developer or maintainer
> >of them needs to either submit them or at least
> approve their
> >submission for inclusion.
> >  
> >
> I'm not suggesting adding the drivers as they are
> now in the kernel.  
> I'm recommending taking those drivers, revising them
> to fix whatever 
> problems they had (including writing an ALSA driver
> for the sound card 
> driver), and releasing the revised modules.  Or
> would even that still 
> need the original developer's approval?
> 
> >How about posting their web locations (wherever you
> found them)
> >in case someone is interested..?
> >  
> >
> I think it was Linuxant (http://www.linuxant.com). 
> The links in a HOWTO 
> file on Conexant modems redirect to that.  I got
> them somewhere for 
> free, whereas Linuxant charges for a full version,
> but either I can't 
> remember where I got them from or the links I got
> them at redirect to 
> Linuxant.  And the documentation in the file doesn't
> list a Web site, 
> but it does mention a copyright by Conexant, but I'm
> unsure whether 
> that's for the driver itself or for the device. 
> Same deal with the 
> Riptide sound card driver.  That was from Linuxant,
> but they're not 
> posting that on their Web site any more, so I'm glad
> I got it when I 
> did.  The file name for the HSF modem driver is 
> "hsflinmodem-4.06.06.02.tar.bz2" and the one for the
> Riptide sound card 
> is "riptide-0.6lnxtbeta03122800.tar.bz2".  You might
> try doing a Web 
> search for those files.  Actually, I don't remember
> whether they were 
> originally compressed in .bz2 format or if they were
> compressed in .gz 
> format and I recompressed them in .bz2 format (as I
> did for a lot of 
> stuff), so make sure you try both extensions.

the address your looking for is
http://www.linuxant.com/drivers/riptide/download.php
and
http://www.linuxant.com/drivers/hsf/full/download.php

> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


=====
John Carlson
<carlsj@yahoo.com>


		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
