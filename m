Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317595AbSFNIsc>; Fri, 14 Jun 2002 04:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317600AbSFNIsb>; Fri, 14 Jun 2002 04:48:31 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:15110
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317595AbSFNIsb>; Fri, 14 Jun 2002 04:48:31 -0400
Date: Fri, 14 Jun 2002 01:45:20 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Nick Evgeniev <nick@octet.spb.ru>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <20020614103746.A324@ucw.cz>
Message-ID: <Pine.LNX.4.10.10206140140040.21513-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2002, Vojtech Pavlik wrote:

> On Fri, Jun 14, 2002 at 01:20:34AM -0700, Andre Hedrick wrote:
> > 
> > Nick,
> > 
> > http://www.tecchannel.de/hardware/817/index.html
> > 
> > Read about the JUNK hardware base you are working with.
> > This is one of the reasons people avoid VIA.
> 
> Hmm, I don't want to interfere in this nicely-growing flamethrowing, but
> Andre, you might have noticed, that Nick is saying that it actually
> *works* on the VIA controller and doesn't on the Promise one. Plus older
> kernels do work on the Promise controller. That's clearly a software
> problem.

Well if you have not read, I offered to export the changes to the kernel
he states works as a way to isolate the driver from other changes.
We have Promise adding their two cents, also.

How about you rewriting the driver an take my name out of it too.
Then you can have all the credit be yours.

Regards,

Andre Hedrick
LAD Storage Consulting Group

