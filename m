Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290033AbSAQQzY>; Thu, 17 Jan 2002 11:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290034AbSAQQzP>; Thu, 17 Jan 2002 11:55:15 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:31445 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S290033AbSAQQzH>;
	Thu, 17 Jan 2002 11:55:07 -0500
Date: Thu, 17 Jan 2002 17:54:46 +0100
From: David Weinehall <tao@acc.umu.se>
To: bill davidsen <davidsen@tmr.com>
Cc: romano@dea.icai.upco.es, linux-kernel@vger.kernel.org
Subject: Re: Power off NOT working, kernel 2.4.16
Message-ID: <20020117175446.P5235@khan.acc.umu.se>
In-Reply-To: <3C45F45C.5000005@mbnet.fi> <20020117134753.4330b0b5.sfr@canb.auug.org.au> <3C468109.3090401@mbnet.fi> <20020117102302.A19119@pern.dea.icai.upco.es> <200201171309.IAA01163@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200201171309.IAA01163@gatekeeper.tmr.com>; from davidsen@tmr.com on Thu, Jan 17, 2002 at 08:09:59AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 08:09:59AM -0500, bill davidsen wrote:
> In article <20020117102302.A19119@pern.dea.icai.upco.es> you write:
> | On Thu, Jan 17, 2002 at 09:45:13AM +0200, Joonas Koivunen wrote:
> | > 
> | > Yes, it's there, and I have also tried poweroff, no effect, last text 
> | > line I see is 'Power down.' and the system is succefully halted, not 
> | > switched off.
> | 
> | I have the same problem on my home box (Athlon with AMD mo-bo). RedHat
> | compiled kernel _do_ poweroff (although with a flashing oops just before
> | power goes off), but none of vanillas kernel can do it --- I tried with and
> | without ACPI, with APM real-mode call, whatever. 
> 
>   I've had that problem with my BP6 for so long I stopped complaining.
> Time to start again, I guess.
> 
>                                  WHINE
> 
>   There, now I feel better ;-) Really annoying, though, to have to boot
> NT just to turn the machine off.

Ever tried holding the power-button for 3 seconds?!


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
