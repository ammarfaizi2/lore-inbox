Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbRHMTw4>; Mon, 13 Aug 2001 15:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbRHMTwq>; Mon, 13 Aug 2001 15:52:46 -0400
Received: from [209.202.108.240] ([209.202.108.240]:1544 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S265249AbRHMTwh>; Mon, 13 Aug 2001 15:52:37 -0400
Date: Mon, 13 Aug 2001 15:52:37 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8-ac2 USB keyboard capslock hang
In-Reply-To: <E15WLxI-0007tC-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108131550470.3127-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, Alan Cox wrote:

> > On Mon, Aug 13, 2001, Peter J. Braam <braam@clusterfs.com> wrote:
> > > I have a Logitech Internet USB keyboard, attached to an IBM TP T20.
> > >
> > > In the above system pressing Caps lock twice (i.e. switching capslock
> > > off) freezes the system completely.
> > >
> > > The last system that didn't do so for me was Rosswell's kernel.
> > > Does anyone know about this?  Thanks a lot!
> >
> > Rosswell?
>
> Roswell is the Red Hat 7.2 beta, so its probably another bug that was fixed
> in the USB and input updates in -ac

After extracting the kernel package, it looks like 2.4.6-ac5.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

