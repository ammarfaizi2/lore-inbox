Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSHTT5b>; Tue, 20 Aug 2002 15:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSHTT5b>; Tue, 20 Aug 2002 15:57:31 -0400
Received: from host.greatconnect.com ([209.239.40.135]:40978 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S317282AbSHTT5a>; Tue, 20 Aug 2002 15:57:30 -0400
Subject: Re: SE7500CW2 motherboard
From: Samuel Flory <sflory@rackable.com>
To: Jason Zebchuk <jason@consensys.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <033f01c247d4$1abd5610$4902a8c0@consensys.com>
References: <033f01c247d4$1abd5610$4902a8c0@consensys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Aug 2002 13:00:50 -0700
Message-Id: <1029873651.3947.97.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Try updating to the latest intel bios.  I had a lot of issues with the
keyboard not working, and at least once I swear using it crashed the
system.


PS- I really recommend using the intel SE7500WV2 instead of the CW2. 
It's a bit more in cost, but well worth it if you can afford it.

On Mon, 2002-08-19 at 15:59, Jason Zebchuk wrote:
> Hi,
> 
>     I'm having problems with the kernel debugger on a number of machines
> with Intel SE7500CW2 motherboards.
> 
>     When attempting to enter the debugger, either by pressing "PAUSE" or at
> a breakpoint, one of  four things will happen:
> 
>     1.  It works as expected.
> 
>     2. It reboots.
> 
>     3.  It hangs.  ie. input seems to have no effect, no signs of activity,
> forced to power down.
> 
>     4.  It prints:
> 
>             PCI System Error on Bus/Device/Function 00B0h
>             PCI Parity Error on Bus/Device/Function 00B0h
> 
>         and then continues to function as expected.
> 
> 
>     In addition, it also occasionally hangs or reboots after entering the
> debugger successfully and using it for a short while.
> 
> 
>     I'm using a 2.4.18 kernel, and the problems are only happening on Intel
> SE7500CW2 motherboards (ie.  I don't have problems on say an Intel SDS2).
> 
>     Has anyone seen any similar problems?  Has anyone had problems using
> this motherboard?  Does anyone have any suggestions?
> 
> Thanks,
> 
> Jason Zebchuk
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


