Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270693AbRHNStd>; Tue, 14 Aug 2001 14:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270695AbRHNSt0>; Tue, 14 Aug 2001 14:49:26 -0400
Received: from web14607.mail.yahoo.com ([216.136.224.87]:50949 "HELO
	web14607.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270693AbRHNStG>; Tue, 14 Aug 2001 14:49:06 -0400
Message-ID: <20010814160235.88152.qmail@web14607.mail.yahoo.com>
Date: Tue, 14 Aug 2001 09:02:34 -0700 (PDT)
From: cardhore <cardhore@yahoo.com>
Subject: RE: cs4232 sound chip problem
To: "Woller, Thomas" <twoller@crystal.cirrus.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <973C11FE0E3ED41183B200508BC7774C022FB6F9@csexchange.crystal.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Woller, Thomas" <twoller@crystal.cirrus.com>
wrote:
> Do you have a cs46xx chip or a cs4232 on that
> motherboard? I think that we
> took care of most of the pops with the cs46xx
> driver, but I haven't ever
> looked at the cs4232 driver (ISA part).
> tom

The chip itself reads "Crystal CS4236B-KQ".
It is directly onboard the motherboard and uses the
isa bus.  /proc/isapnp gives:  Card 1
'CSC0b35:CS4236B' PnP version 1.0 Product version 0.4

> 
>  -----Original Message-----
> From: 	cardhore [mailto:cardhore@yahoo.com] 
> Sent:	Monday, August 13, 2001 8:40 PM
> To:	linux-kernel@vger.kernel.org
> Cc:	nils@kernelconcepts.de;
> twoller@crystal.cirrus.com
> Subject:	cs4232 sound chip problem
> 
> *Please CC all responses to cardhore@yahoo.com as I
> am
> not subscribed.
> 
> I'm using the cs4232 sound driver, in Linux 2.4.8
> (or
> 2.4.7) for my motherboard's onboard chip.  (The
> motherboard is the Intel SE440BX.)  Whenever the
> sound
> device is opened, it makes a loud "pop."  Does this
> in
> all kernels.  Any help would be appreciated! 
> Thanks.
> 
> __________________________________________________
> Do You Yahoo!?
> Send instant messages & get email alerts with Yahoo!
> Messenger.
> http://im.yahoo.com/


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
