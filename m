Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271795AbRH0RPq>; Mon, 27 Aug 2001 13:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271794AbRH0RPi>; Mon, 27 Aug 2001 13:15:38 -0400
Received: from dvorak.nscl.msu.edu ([35.8.33.99]:30729 "EHLO dvorak")
	by vger.kernel.org with ESMTP id <S271792AbRH0RP2>;
	Mon, 27 Aug 2001 13:15:28 -0400
Date: Mon, 27 Aug 2001 13:29:39 -0400 (EDT)
From: Jens Hoefkens <hoefkens@msu.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 boot failure
In-Reply-To: <Pine.LNX.3.95.1010827123227.31563A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0108271254460.8066-100000@dvorak>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [SNIPPED...]
> 
> There may be a configuration problem. Make sure that you do:
> 
> make oldconfig
> make dep
> make clean
> make bzImage
> make modules
> make modules_install
> 
> ... after you set the SMP variable. A mixture of SMP and non-SMP
> code can cause hangs.

Hi Richard.

I actually did all that (and even several times), since at first I was
assuming that I have a local problem (LILO, compiler, config, etc.).

Ciao,
	
							Jens

-------------------------------------------------------------------------
   Jens Hoefkens                                   Phone:  517-333-6441
   NSCL / MSU                                      Mobile: 517-402-6251
   East Lansing, MI 48824                          Fax:    517-353-5967
   USA   
   
   http://bt.nscl.msu.edu/~hoefkens
-------------------------------------------------------------------------


