Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312584AbSCYVVg>; Mon, 25 Mar 2002 16:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312585AbSCYVV1>; Mon, 25 Mar 2002 16:21:27 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:29188
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312584AbSCYVVI>; Mon, 25 Mar 2002 16:21:08 -0500
Date: Mon, 25 Mar 2002 13:20:46 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Wakko Warner <wakko@animx.eu.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE and hot-swap disk caddies
In-Reply-To: <20020325152617.A18605@animx.eu.org>
Message-ID: <Pine.LNX.4.10.10203251319100.1305-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002, Wakko Warner wrote:

> > >   The way you say that makes me think that it does support at some other
> > > level... hot swap controller? Doesn't match MY hardware. Hot swap
> > 
> > Controller level hotswap works mostly (think about pcmcia ide for example)
> 
> Just to throw this out there.  Is it possible to make the ide subsystem look
> like a scsi controller ?  that way the scsi layer could insert/remove
> devices.  say: ide0/1 = scsi0 (assuming no other scsi controllers) and hda =
> scsi0 channel0 id0 lun0  and hdc = scsi0 channel1 id0 lun0 ...
> 
> Personally, if it's doable, i'd like it.

Hardware is different.
You can paint a goose yellow and call it a duck, but it is still a goose.
The electrical/electronic interface will kill you!

Cheers,

Andre Hedrick
LAD Storage Consulting Group

