Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272794AbRIMFfc>; Thu, 13 Sep 2001 01:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272859AbRIMFfN>; Thu, 13 Sep 2001 01:35:13 -0400
Received: from samar.sasken.com ([164.164.56.2]:15011 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S272794AbRIMFfB>;
	Thu, 13 Sep 2001 01:35:01 -0400
Message-ID: <3BA0458B.96509EB7@sasken.com>
Date: Thu, 13 Sep 2001 11:05:07 +0530
From: Manoj Sontakke <manojs@sasken.com>
Organization: Sasken Communication Technologies Limited.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francis Galiegue <fg@mandrakesoft.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Packet tapping
In-Reply-To: <Pine.LNX.4.30.0109120542330.4681-100000@toy.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot. I was looking for a pointer. I knew its possible but lost
track of "how".
Thnaks again.
Manoj

Francis Galiegue wrote:
> 
> On Wed, 12 Sep 2001, Manoj Sontakke wrote:
> 
> >
> > Hi,
> >       Is it possible to tap a packet and send it to a userlevel program
> > before it is sent to appropriate receive function (say ip_rcv()). The
> > user level program will give the packet back to the kernel for delivery
> > to appropriate receive function.
> >       In short, is it possible to have a protocol stack (between layer 2 and
> > 3) to be implemented in useland.
> >
> >       Is Tun/Tap driver useful here?
> 
> Isn't the QUEUE driver from iptables done for such cases?
