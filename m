Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284460AbRLYDZy>; Mon, 24 Dec 2001 22:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285377AbRLYDZp>; Mon, 24 Dec 2001 22:25:45 -0500
Received: from [66.13.29.10] ([66.13.29.10]:47772 "EHLO Bluesong.NET")
	by vger.kernel.org with ESMTP id <S284460AbRLYDZe>;
	Mon, 24 Dec 2001 22:25:34 -0500
Message-Id: <200112250328.fBP3S9B31852@Bluesong.NET>
Content-Type: text/plain; charset=US-ASCII
From: "Jack F. Vogel" <jfv@trane.bluesong.net>
Reply-To: jfv@bluesong.net
To: Greg KH <greg@kroah.com>, Juergen Sauer <jojo@automatix.de>
Subject: Re: [Linux-usb-users] VIA Chipsets + USB + SMP == UGLY TRASH
Date: Mon, 24 Dec 2001 19:28:08 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <E16IRTQ-0003oN-00@s.automatix.de> <20011224104724.B8215@kroah.com>
In-Reply-To: <20011224104724.B8215@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 December 2001 10:47 am, Greg KH wrote:
> On Mon, Dec 24, 2001 at 10:32:49AM +0100, Juergen Sauer wrote:
> > Hi!
> > Merry X-Mas everywhere !
> >

And a Happy New Year to us all :)

> > So, my USB tryout is over.
> > This is the expierience report:
> > You should not try to use VIA Chipsets + SMP + USB, that's
> > the worst thinkable idea. It's junk (usb-Part).
>
> Depends on the motherboard.  What one do you have?
>
..... [ snipped]
>
> I have a SMP motherboard that requires this (noapic setting).  With that
> set, everything works fine including bulk transfers and all other USB
> devices that I have.

I also have an SMP system using VIA. Its an Asus dual coppermine, I
do not recall the exact board number.

I don't have a large variety of USB devices on it. But what I have used
works fine.

This motherboard does have an IOAPIC, so does not require the noapic
option.

One thing of note, there has been a bit of activity in the apic code recently,
you never did say what kernel version this was using, maybe a recent 
vintage would help??

Merry New Year :)

--
Jack F. Vogel	
IBM xSeries Linux Solutions
jfv@us.ibm.com (at work)
jfv@Bluesong.NET (at home)


