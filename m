Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263574AbREYG07>; Fri, 25 May 2001 02:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263575AbREYG0k>; Fri, 25 May 2001 02:26:40 -0400
Received: from beppo.feral.com ([192.67.166.79]:5638 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S263574AbREYG02>;
	Fri, 25 May 2001 02:26:28 -0400
Date: Thu, 24 May 2001 23:26:20 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: Aaron Lehmann <aaronl@vitelus.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
In-Reply-To: <20010524225702.A23155@vitelus.com>
Message-ID: <Pine.BSF.4.21.0105242325460.4980-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sure- that's not BSD. You were speaking about all kinds of firmware, at least
I thought you were. Must be too short on sleep.


On Thu, 24 May 2001, Aaron Lehmann wrote:

> On Thu, May 24, 2001 at 10:00:15PM -0700, Matthew Jacob wrote:
> > 
> > It is my opinion, such as it is, that a BSD copyright inside of a GPL package
> > does not, per se, weaken the GPL. The BSD copyright is, in fact, the more
> > permissive license. My reading of both licenses would have me believe that a
> > BSD licensed piece of software cannot then permit the linux kernel to be
> > binary only. The BSD licencse does not, per se, prohibit any form of binary
> > redistribution- nor does it require it. The GPL covers the whole kernel, and
> > if a BSD piece of code is directly linked in (not modloaded), it would have to
> > also be under GPL.
> > 
> > So pieces of linux-kernel which have BSD copyright are probably just fine.
> 
> /* keyspan_usa18x_fw.h
>   
>    Generated from Keyspan firmware image Wed Jul  5 09:18:29 2000 EST
>    This firmware is for the Keyspan USA-18X Serial Adaptor
> 
>    "The firmware contained herein as keyspan_usa18x_fw.h is
>    Copyright (C) 1999-2000 Keyspan, A division of InnoSys Incorporated
>    ("Keyspan"), as an unpublished work.  This notice does not imply
>    unrestricted or public access to this firmware which is a trade secret of
>    Keyspan, and which may not be reproduced, used, sold or transferred to any
>    third party without Keyspan's prior written consent.  All Rights Reserved.
> 
>    This firmware may not be modified and may only be used with the Keyspan 
>                  ^^^^^^^^^^^^^^^^^^^
>    USA-18X Serial Adapter.  Distribution and/or Modification of the
>    keyspan.c driver which includes this firmware, in whole or in part,
>    requires the inclusion of this statement."
> 
> That doesn't look like the BSD license to me.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

