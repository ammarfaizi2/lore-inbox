Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRBVPVU>; Thu, 22 Feb 2001 10:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129300AbRBVPVK>; Thu, 22 Feb 2001 10:21:10 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:6660 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S129156AbRBVPU7>;
	Thu, 22 Feb 2001 10:20:59 -0500
Date: Thu, 22 Feb 2001 12:20:55 -0300
From: Rogerio Brito <rbrito@iname.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] VIA 4.2x driver for 2.2 kernels (fwd)
Message-ID: <20010222122055.A1278@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This message was apparently intended to be sent to the list.


	[]s, Roger...

----- Forwarded message from Pozsar Balazs <pozsy@sch.bme.hu> -----

From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Rogerio Brito <rbrito@iname.com>
Subject: Re: [patch] VIA 4.2x driver for 2.2 kernels
Date: Thu, 22 Feb 2001 01:04:27 +0100 (MET)
Message-ID: <Pine.GSO.4.30.0102220103290.8797-100000@balu>


The kernel doesn't seem to set 32bit io transfers by default. Is it
dangerous or unrecommended to set it with hdparm?


On Wed, 21 Feb 2001, Rogerio Brito wrote:

> On Feb 21 2001, Vojtech Pavlik wrote:
> > On Tue, Feb 20, 2001 at 11:15:02PM -0800, Shane Wegner wrote:
> > > Ok, can I still use -u1 -k1 -c1 on the drives or is it even
> > > necessary anymore.
> >
> > If you enable automatic DMA in the kernel config, it isn't necessary
> > at all. The VIA driver sets up everything.
>
> 	Ok. Please disregard my last message (this one contains
> 	exactly what I was looking for).
>
> > 4) But VIA is still set to PIO mode
>
> 	Why does this happen?
>
> 	And what about the other options to hdparm (-u1 -k1 -c1)? Are
> 	they potentially dangerous also?
>
>
> 	[]s, Roger...
>
>



----- End forwarded message -----

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
