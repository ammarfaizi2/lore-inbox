Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271646AbRHUMvl>; Tue, 21 Aug 2001 08:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271651AbRHUMva>; Tue, 21 Aug 2001 08:51:30 -0400
Received: from buserror-extern.convergence.de ([212.84.236.66]:18950 "EHLO
	jupiter") by vger.kernel.org with ESMTP id <S271646AbRHUMvU>;
	Tue, 21 Aug 2001 08:51:20 -0400
Date: Tue, 21 Aug 2001 14:35:08 +0200
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Milind <dmilind@india.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: Info about /dev/kmem required
Message-ID: <20010821143508.A17278@jupiter>
In-Reply-To: <3B7D232B.FEA189AD@india.hp.com> <20010817175739.I19385@arthur.ubicom.tudelft.nl> <20010820202108.A7121@jupiter> <20010821143954.D2673@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010821143954.D2673@arthur.ubicom.tudelft.nl>
User-Agent: Mutt/1.3.18i
From: Frank Neuber <neuber@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2001 at 02:39:54PM +0200, Erik Mouw wrote:
> On Mon, Aug 20, 2001 at 08:21:08PM +0200, Frank Neuber wrote:
> > I think You can use /dev/kmem as an corefile for gdb. So it is
> > possible to debug the linux kernel (of course read only :-)).
> 
> No, that's what /proc/kcore is for.
You are right!! Sorry it was my mistake.
 Frank

-- 
Dipl.-Ing. Elektrotechnik     convergence integrated media gmbh / HW
Frank Neuber                        Rosenthalerstr.51 / 10178 Berlin
Email:  neuber@convergence.de           Phone:  +49(0)30-72 62 06 50
WWW:    www.convergence.de              Fax:    +49(0)30-72 62 06 55
