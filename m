Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263554AbREYF5S>; Fri, 25 May 2001 01:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263552AbREYF5I>; Fri, 25 May 2001 01:57:08 -0400
Received: from vitelus.com ([64.81.36.147]:1291 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S263548AbREYF5F>;
	Fri, 25 May 2001 01:57:05 -0400
Date: Thu, 24 May 2001 22:57:02 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Matthew Jacob <mjacob@feral.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Message-ID: <20010524225702.A23155@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.21.0105242155540.4849-100000@beppo.feral.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 10:00:15PM -0700, Matthew Jacob wrote:
> 
> It is my opinion, such as it is, that a BSD copyright inside of a GPL package
> does not, per se, weaken the GPL. The BSD copyright is, in fact, the more
> permissive license. My reading of both licenses would have me believe that a
> BSD licensed piece of software cannot then permit the linux kernel to be
> binary only. The BSD licencse does not, per se, prohibit any form of binary
> redistribution- nor does it require it. The GPL covers the whole kernel, and
> if a BSD piece of code is directly linked in (not modloaded), it would have to
> also be under GPL.
> 
> So pieces of linux-kernel which have BSD copyright are probably just fine.

/* keyspan_usa18x_fw.h
  
   Generated from Keyspan firmware image Wed Jul  5 09:18:29 2000 EST
   This firmware is for the Keyspan USA-18X Serial Adaptor

   "The firmware contained herein as keyspan_usa18x_fw.h is
   Copyright (C) 1999-2000 Keyspan, A division of InnoSys Incorporated
   ("Keyspan"), as an unpublished work.  This notice does not imply
   unrestricted or public access to this firmware which is a trade secret of
   Keyspan, and which may not be reproduced, used, sold or transferred to any
   third party without Keyspan's prior written consent.  All Rights Reserved.

   This firmware may not be modified and may only be used with the Keyspan 
                 ^^^^^^^^^^^^^^^^^^^
   USA-18X Serial Adapter.  Distribution and/or Modification of the
   keyspan.c driver which includes this firmware, in whole or in part,
   requires the inclusion of this statement."

That doesn't look like the BSD license to me.
