Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136024AbREJCkr>; Wed, 9 May 2001 22:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136035AbREJCkh>; Wed, 9 May 2001 22:40:37 -0400
Received: from coorong.anu.edu.au ([150.203.141.5]:47004 "EHLO
	coorong.anu.edu.au") by vger.kernel.org with ESMTP
	id <S136024AbREJCkc>; Wed, 9 May 2001 22:40:32 -0400
Message-ID: <3AF9FF86.9DB15723@tltsu.anu.edu.au>
Date: Thu, 10 May 2001 12:40:06 +1000
From: Robert Cohen <robert@coorong.anu.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Question: Status of VIA chipsets and 2.2 kernels
In-Reply-To: <Pine.LNX.4.10.10105091135360.1509-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:
> 
> >  a P3 machine with a ASUS CUV4X-E motherboard which uses the apollo pro
> > 694X northbridge and a 686B southbridge.
> 
> I haven't seen any reports of problem with this; it's the duals that need
> the noapic workaround at the moment.
> 
> > An athlon machine with an ASUS A7V motherboard which uses a KT133
> > (VT8363) northbridge and a 686A southbridge.
> 
> works fine.  my main workstation is a gigabyte version of this,
> and has never had any problems (and delivers great performance).
> 
> > An athlon machine with an ASUS A7V133 motherboard which uses a KT133A
> > (VT8363A) northbridge and a 686B southbridge.
> 
> this is the one that has some kind of issue, for which there are several
> workarounds.  it's not entirely clear whether the workarounds make sense/etc.

I was worried that the P3 machine with the Apollo pro chipset is using
the 686B southbridge and might
share the DMA problems. Anyone know if this is a problem?

--
Robert Cohen
Unix Support
TLTSU
Australian National University
Ph: 612 58389
