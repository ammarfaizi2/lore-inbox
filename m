Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbSJHR4v>; Tue, 8 Oct 2002 13:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261311AbSJHR4u>; Tue, 8 Oct 2002 13:56:50 -0400
Received: from maile.telia.com ([194.22.190.16]:31433 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S261301AbSJHR4K>;
	Tue, 8 Oct 2002 13:56:10 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:01:34 +0200 (CEST)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@p4.localdomain
To: Greg KH <greg@kroah.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.5.40 panic in uhci-hcd
In-Reply-To: <20021008071351.GQ1780@kroah.com>
Message-ID: <Pine.LNX.4.44.0210081959400.6558-100000@p4.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Greg KH wrote:

> On Sun, Oct 06, 2002 at 02:03:49PM +0200, Peter Osterlund wrote:
> > Sometimes when booting 2.5.40 and my Freecom USB-IDE controller (CDRW)
> > is connected, the kernel panics when trying to initialize the usb
> > subsystem. It happens right after the RH73 boot scripts print out:
> > 
> >         Initializing USB controller (uhci-hcd):  [  OK  ]
> > 
> > In 2.5.39, this happened every time I tried to boot, but in 2.5.40 it
> > seems to happen about 20% of the time.
> 
> Hey, we're getting better :)
> 
> How does 2.5.41 work for you?

It seems to be fixed. Thanks.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

