Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290184AbSCKTki>; Mon, 11 Mar 2002 14:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290277AbSCKTk3>; Mon, 11 Mar 2002 14:40:29 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:9223 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S290184AbSCKTkV>; Mon, 11 Mar 2002 14:40:21 -0500
Date: Mon, 11 Mar 2002 11:39:31 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Gunther Mayer <gunther.mayer@gmx.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19, return of taskfile
In-Reply-To: <E16kVlK-0001VU-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10203111137590.10583-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Alan Cox wrote:

> > Currently your taskfile access is hardcoded in tables in your ide patches and this is
> > 
> > inflexible (e.g. cannot support future commands, unknown at the time of your writing)
> > !
> 
> It stops things like disk level DRM nicely too

Stop using "logic", it is clear it is not a "Darwin" thing to do.

Cheers,

Andre Hedrick
The Second Linux X-IDE guy

