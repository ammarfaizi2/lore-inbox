Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269504AbRGaWBP>; Tue, 31 Jul 2001 18:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269495AbRGaWBF>; Tue, 31 Jul 2001 18:01:05 -0400
Received: from mail.zmailer.org ([194.252.70.162]:55557 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S269493AbRGaWA5>;
	Tue, 31 Jul 2001 18:00:57 -0400
Date: Wed, 1 Aug 2001 01:00:45 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Riley Williams <rhw@MemAlpha.CX>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Virii on vger.kernel.org lists
Message-ID: <20010801010045.B2650@mea-ext.zmailer.org>
In-Reply-To: <20010731152714.R2650@mea-ext.zmailer.org> <Pine.LNX.4.33.0107311858360.23876-100000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107311858360.23876-100000@infradead.org>; from rhw@MemAlpha.CX on Tue, Jul 31, 2001 at 07:02:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 07:02:18PM +0100, Riley Williams wrote:
> Hi Matti.
> 
> First, let's have a subject that reflects the content...

  Ack, should have done that long ago...

....
>  > Of course in case of Viruses using OE security bugs, we all are
>  > seeing the distilled evil.
> 
> Is there any way we can set up an automatic virus scan of all
> attachments at vger, and have it deal with any virii at source?
> 
> Come to that, is there a decent Linux-based virus scanner around?

   I have been asked, several times, if I could integrate some
virus scanner wrapper, like Amavis, into ZMailer.  The more I think
of that, the more it appears to be stuff for 3.x series of ZMailer;
not for current 2.x  ...  but the technology slated for 3.x implements
something like 2/3 of Amavis for other internal system purposes ...

Nevertheless, that is just the interface from email system to separate 
file scanner.  Those scanners are available in abundance for winblows,
but are very rare for anything else.   Amavis pages seem to point to
a bunch of products with Linux support, so perhaps there are something
usefull to be plugged in ?


>  > Doing it at lists is waste of time, and misses *MY* attention!
> Hopefully, this caught your attention...
> 
> Best wishes from Riley.

/Matti Aarnio
