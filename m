Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbTFNGPV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 02:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbTFNGPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 02:15:21 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:33664 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265596AbTFNGPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 02:15:15 -0400
Date: Sat, 14 Jun 2003 07:36:03 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306140636.h5E6a3JA000661@81-2-122-30.bradfords.org.uk>
To: alan@lxorguk.ukuu.org.uk, joe.korty@ccur.com
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Cc: akpm@digeo.com, greg@kroah.com, linux-kernel@vger.kernel.org,
       mochel@osdl.org, paulus@samba.org, rml@tech9.net, sdake@mvista.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Turns out its 486 and higher, so you win.
> > Perhaps it's time to remove 386 support from 2.5?  Users
> > of very old machines can stick with 2.0, 2.2 or 2.4.

I strongly disagree, 386 support is important for the embedded
market.

> You have to solve these problems generally anyway, and lots of
> other platforms have limited locking functions.

Including future Linux platforms.

(possibly).

John.
