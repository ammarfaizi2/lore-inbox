Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265587AbUAGRlS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUAGRlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:41:17 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:24327 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265587AbUAGRlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:41:13 -0500
Date: Wed, 7 Jan 2004 17:41:11 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Marek Habersack <grendel@caudium.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb and highmem?
In-Reply-To: <20040107171719.GC1119@thanes.org>
Message-ID: <Pine.LNX.4.44.0401071740220.31020-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This is because of the radeonfb driver ioremapping the framebuffer memeory 
> > whichcan be really big. Once the driver is fully accelerated then we can 
> > remove the ioremap function in the driver.
> I see, is there any ETA for that to happen? And, if you need some testing -
> I will be glad to help

In the next few weeks. 

