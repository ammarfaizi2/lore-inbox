Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265496AbTFMT54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265502AbTFMT54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:57:56 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:60933 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265496AbTFMT5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:57:55 -0400
Date: Fri, 13 Jun 2003 21:11:42 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: John Bradford <john@grabjohn.com>
cc: terje_fb@yahoo.no, <linux-kernel@vger.kernel.org>
Subject: Re: Real multi-user linux
In-Reply-To: <200306131743.h5DHhNdv000312@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0306132106250.29353-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > >     The next stage will be non PC boards supporting more than
> > > one graphics display output. Every now and then you see such a
> > > board. I seen a 8 graphics chip board with 8 video outputs.
> 
> > As the number of terminals increases you might want to investigate the
> > possibility of terminal driving units connected to the main box, like
> > this:
> 
> [snip diagram]
> 
> Of course, those terminal driving units could actually then just be
> replaced with multiple-display-and-keyboard-enabled X servers.
> 
> So, instead of trying to add more and more terminals to a single box,
> you could stick with four-headed X servers, which would probably be
> more scalable.

The biggest limitation is the PCI bus. Only so many cards can go in. I 
guess you could fill the machine up with graphics cards and go with 
external USB audio and TV tuner cards. One to match each graphics card.

