Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276627AbRJGTke>; Sun, 7 Oct 2001 15:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276622AbRJGTkZ>; Sun, 7 Oct 2001 15:40:25 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:64243 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S276627AbRJGTkP>; Sun, 7 Oct 2001 15:40:15 -0400
Date: Sun, 7 Oct 2001 15:39:42 -0400
From: Willem Riede <wriede@home.com>
To: Steven Walter <srwalter@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan Tiger MP AMD760 chipset support
Message-ID: <20011007153942.C1424@linnie.riede.org>
In-Reply-To: <20011007132349.A1424@linnie.riede.org> <20011007141205.B4000@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011007141205.B4000@hapablap.dyn.dhs.org>; from srwalter@yahoo.com on Sun, Oct 07, 2001 at 15:12:05 -0400
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's not the issue, I'm not that ignorant. sensors-detect
just doesn't find anything!

Willem Riede.
-------------
On 2001.10.07 15:12 Steven Walter wrote:
> On Sun, Oct 07, 2001 at 01:23:49PM -0400, Willem Riede wrote:
> > with reference to AMD760 (IDE?) support on a Tyan K7 Thunder,
> > I was somewhat surprised to find the chipset:
> > 
> >  	AMD-762 North bridge & AMD-766 South bridge
> > 	Winbond W83627HF Super I/O ASIC
> >  	Winbond W83782D hardware monitoring ASIC
> > 
> > only partly recognized by my 2.4.9ac18 based kernel. 
> > One problem is that the temperature sensors are not detected 
> > (I'm reluctant to torture my system if I can't watch out for 
> > it overheating).
> > 
> > Does anyone know the AMD760 support status? Any pointers
> > for (experimental) patches?
> 
> Look into the lm_sensors patch; it supports many such hardware
> monitoring chips, and I believe that yours is one of them.
> -- 
> -Steven

> 
