Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290796AbSCKTni>; Mon, 11 Mar 2002 14:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290767AbSCKTn2>; Mon, 11 Mar 2002 14:43:28 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:10759
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S290587AbSCKTnS>; Mon, 11 Mar 2002 14:43:18 -0500
Date: Mon, 11 Mar 2002 11:42:22 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gunther Mayer <gunther.mayer@gmx.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19, return of taskfile
In-Reply-To: <Pine.GSO.4.21.0203111436120.14945-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10203111140200.10583-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Alexander Viro wrote:

> 
> 
> On Mon, 11 Mar 2002, Alan Cox wrote:
> 
> > > Currently your taskfile access is hardcoded in tables in your ide patches and this is
> > > 
> > > inflexible (e.g. cannot support future commands, unknown at the time of your writing)
> > > !
> > 
> > It stops things like disk level DRM nicely too
> 
> Umm...  By what magic?  The entire interface _is_ root-only, isn't it?
> And root can do a lot of fun stuff, starting with editing the kernel
> image...
> 

Well why did you not object to the SCSI sequencer in the past.
Your argument proves that hardware venders will not like Linux and the
childlike additude of not protecting the hardware.  ROOT is a brained
GAWD that should run for local Politics.

--andre

