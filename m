Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269043AbRHPXf2>; Thu, 16 Aug 2001 19:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269092AbRHPXfT>; Thu, 16 Aug 2001 19:35:19 -0400
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:916 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S269043AbRHPXfL>; Thu, 16 Aug 2001 19:35:11 -0400
Message-ID: <3B7C58BB.6D67DD7A@bigfoot.com>
Date: Thu, 16 Aug 2001 16:35:23 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.20p6ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.20pre series and booting problem
In-Reply-To: <20010815172631.A17156@elektroni.ee.tut.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make bzimage?

Petri Kaukasoina wrote:
> 
> Hi
> 
> I just tried to compile kernels from the 2.2.20pre series for the first
> time. 2.2.20pre3 boots ok but pre5-pre9 do not:
> 
> Uncompressing Linux...
> 
> Out of memory
> 
>   -- System halted
> 
> I'm sorry if I this is well-known: I haven't been following the list very
> closely lately. Maybe it has something to do with this:
> 
> o       Add support for the 2.4 boot extensions to 2.2  (H Peter Anvin)
> 
> I tried with gcc-2.7.2.3 + binutils-2.9.1.0.25 and with egcs-1.1.2 +
> binutils-2.11.90.0.19. On a 486 with 48 M RAM and lilo 21.7-5 and on a
> Pentium MMX with 64 M RAM and lilo 19.
--
