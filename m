Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270656AbRHNSnn>; Tue, 14 Aug 2001 14:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270669AbRHNSnd>; Tue, 14 Aug 2001 14:43:33 -0400
Received: from cs6625192-102.austin.rr.com ([66.25.192.102]:6408 "EHLO
	mail1.cirrus.com") by vger.kernel.org with ESMTP id <S270632AbRHNSnU>;
	Tue, 14 Aug 2001 14:43:20 -0400
Message-ID: <973C11FE0E3ED41183B200508BC7774C022FB6FB@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <twoller@crystal.cirrus.com>
To: "'cardhore'" <cardhore@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: cs4232 sound chip problem
Date: Tue, 14 Aug 2001 11:20:47 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't help then. Sorry bout that.
tom

 -----Original Message-----
From: 	cardhore [mailto:cardhore@yahoo.com] 
Sent:	Tuesday, August 14, 2001 11:03 AM
To:	Woller, Thomas
Cc:	linux-kernel@vger.kernel.org
Subject:	RE: cs4232 sound chip problem

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
