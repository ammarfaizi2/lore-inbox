Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRCMSIS>; Tue, 13 Mar 2001 13:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131163AbRCMSII>; Tue, 13 Mar 2001 13:08:08 -0500
Received: from [216.161.55.93] ([216.161.55.93]:17653 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S131158AbRCMSHz>;
	Tue, 13 Mar 2001 13:07:55 -0500
Date: Tue, 13 Mar 2001 10:12:27 -0800
From: Greg KH <greg@wirex.com>
To: Pete Toscano <pete.lkml@toscano.org>, linux-kernel@vger.kernel.org
Subject: Re: APIC  usb MPS 1.4 and the 2.4.2 kernel
Message-ID: <20010313101227.B805@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Pete Toscano <pete.lkml@toscano.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200103130245.f2D2j2J01057@janus.local.degeorge.org> <20010313002513.A1664@bubba.toscano.org> <20010313092837.A805@wirex.com> <20010313124954.B5626@bubba.toscano.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010313124954.B5626@bubba.toscano.org>; from pete.lkml@toscano.org on Tue, Mar 13, 2001 at 12:49:54PM -0500
X-Operating-System: Linux 2.4.2-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2001 at 12:49:54PM -0500, Pete Toscano wrote:
> 
> Very interesting.  I had not heard about this.  Are there any SMP boards
> with a VIA chipset that does work well with Linux and USB?  I have an
> old P2B-DS that I had replace with this board as I needed more PCI
> slots.  Heck, for that matter are there any SMP boards that work well
> with Linux and USB that have six or more PCI slots?

If you really want USB to work in APIC mode on the Tiger 133 board,
spend $25 on a USB pci card.  That should work just fine :)

> > But, Linux does seem to run just fine with USB and SMP in the noapic
> > mode, which is a lot better than Win2000 can say, as it doesn't even
> > support the VIA USB chipset on this board at all :)
> 
> How would this express itself?  I recently upgraded from WinME to Win2k
> and it all _seems_ to be working well.  Where would I look to verify
> this?

All I know is this:
	http://support.microsoft.com/support/kb/articles/Q233/1/63.ASP
as I've not run Win2000 on this machine, thankfully....

Also the message board at:
	http://www.usbman.com
is full of comments about the VIA chipsets and the difficulties of
getting them to work properly under Windows.

> Thanks for the info and the update.

No problem, sorry I didn't get back to you sooner with this.

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
