Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSETPA6>; Mon, 20 May 2002 11:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316079AbSETPA4>; Mon, 20 May 2002 11:00:56 -0400
Received: from 209-6-202-152.c3-0.nwt-ubr1.sbo-nwt.ma.cable.rcn.com ([209.6.202.152]:5363
	"EHLO chezrutt.dyndns.org") by vger.kernel.org with ESMTP
	id <S316075AbSETPAw>; Mon, 20 May 2002 11:00:52 -0400
From: John Ruttenberg <rutt@chezrutt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15593.3999.95559.132928@localhost.localdomain>
Date: Mon, 20 May 2002 11:00:47 -0400
To: Marc Lehmann <schmorp@schmorp.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dell Inspiron i8100 with 2 batteries
In-Reply-To: <20020520140909.GA29491@schmorp.de>
X-Mailer: VM 6.96 under Emacs 20.7.1
Reply-to: rutt@chezrutt.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.  That did the trick.  I was beginning to suspect the A8+ bios I was
using and beginning to suspect that a downgrade was in order.  But you gave me
the courage to try.


Marc Lehmann:
> On Fri, May 17, 2002 at 10:25:06AM -0400, John Ruttenberg <rutt@chezrutt.com> wrote:
> > I am using 2.4.18 and have a Dell I8100 with 2 batteries.  If combined charge
> 
> I also have this notebook, and the APM bios is rather broken. You might try
> downgrading your BIOS to A07 or so, that *could* help (it helped here).
> 
> ACPI doesn't work stably on that machine (not here, at least), and doesn't
> seem to be desirable, as reading battery status freezes the machine for
> 0.2s ;)
> 
> -- 
>       -----==-                                             |
>       ----==-- _                                           |
>       ---==---(_)__  __ ____  __       Marc Lehmann      +--
>       --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
>       -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
>     The choice of a GNU generation                       |
>                                                          |
