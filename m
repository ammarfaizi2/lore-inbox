Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265052AbTLWISa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 03:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbTLWISa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 03:18:30 -0500
Received: from [193.138.115.2] ([193.138.115.2]:37637 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265052AbTLWIS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 03:18:29 -0500
Date: Tue, 23 Dec 2003 09:16:00 +0100 (CET)
From: Jesper Juhl <juhl@dif.dk>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in pci_find_subsys & sleeping function called from
 invalid context
In-Reply-To: <20031223004937.GA5341@kroah.com>
Message-ID: <Pine.LNX.4.56.0312230914270.28119@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0312221959460.27724@jju_lnx.backbone.dif.dk>
 <20031223004937.GA5341@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Dec 2003, Greg KH wrote:

> On Mon, Dec 22, 2003 at 08:10:44PM +0100, Jesper Juhl wrote:
> >
> > After upgrading to 2.6.0 (from 2.4.22)I'm getting a lot of the below
> > messages in my logs.
> > I'm well aware that this might purely be a problem with the binary Nvidia
> > drivers I'm using with my Geforce3, especially since I had to use the patches
> > available from http://www.minion.de/ to be able to use those drivers at all,
>
> That's exactly what is causing this problem.  Sorry, nothing we can do
> about it here.
>
I rather expected that to be the case, but as I said I merely
reported it in case there was some fixable problem exposed.

Thank you for taking the time to take a look at it.


/Jesper Juhl

