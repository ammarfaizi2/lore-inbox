Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265538AbTFMVmG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265547AbTFMVmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:42:06 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:59398 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265538AbTFMVlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:41:04 -0400
Date: Fri, 13 Jun 2003 22:54:51 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org, <terje_fb@yahoo.no>
Subject: Re: Real multi-user linux
In-Reply-To: <200306132030.h5DKUYlu000211@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0306132250500.29353-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > So, instead of trying to add more and more terminals to a single box,
> > > you could stick with four-headed X servers, which would probably be
> > > more scalable.
> 
> > The biggest limitation is the PCI bus. Only so many cards can go in. I
> > guess you could fill the machine up with graphics cards and go with
> > external USB audio and TV tuner cards. One to match each graphics card.
> 
> No need:
> 
> A single machine can support four displays, keyboards, and mice easily.  We
> can use such machines as X servers for four people.  Each one can be connected
> via Ethernet to the Linux supercomputer.  That way you get the cost advantages
> of the multi-headed setup, with the scalability of the X server setup.  I think
> you could scale to 64 or 128 users like that.

  Basically you are describing a thin client kind of model. I like to 
create 
high end thin clients but I don't have any funding. Currently thin 
clients don't have the power to do multi-media as well as PCs. 
  I did everything so far with my own money and time. I don't think we 
need a supercomputer. Here is a idea but it would require a good amount 
of work. Create a X server that runs on one remote server and it programs 
the hardware remotely. Now that would save enormously. I started to work on 
this but didn't have time. Just some ideas to throw at you.

