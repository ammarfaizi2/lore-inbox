Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265651AbRF1MOa>; Thu, 28 Jun 2001 08:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265648AbRF1MOT>; Thu, 28 Jun 2001 08:14:19 -0400
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:53002 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S265646AbRF1MON>; Thu, 28 Jun 2001 08:14:13 -0400
Message-ID: <3B3B1F91.FBBFB588@damncats.org>
Date: Thu, 28 Jun 2001 08:14:09 -0400
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J. Nick Koston" <nick@burst.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Asus CUV4X-DLS
In-Reply-To: <20010627215304.D28795@burst.net> <3B3AA1DE.E4419FA8@damncats.org> <20010627233541.A32271@burst.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J. Nick Koston" wrote:
> 
> Thanks for the tips, however it doesn't help :-(

It was worth a shot...

> > Also, try passing "noapic" to the kernel on boot if the problem still
> > persists. The downside is that all interrupts will be handled by a
> > single CPU. There is a definite problem with VIA chipsets.
> >
> Tried this as well (mentioned in my original email)

I realized that after I sent the message. Doh!

I have an AIC7xxxx based SCSI card in my machine as well, hooked up to a
Jaz. I haven't actually used it in ages, but I'll test it to see of the
problem is apparent on CUV4X-D board as well.

John
