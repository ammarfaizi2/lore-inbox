Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268165AbTBSJj6>; Wed, 19 Feb 2003 04:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268166AbTBSJj6>; Wed, 19 Feb 2003 04:39:58 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:32161 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S268165AbTBSJj4>; Wed, 19 Feb 2003 04:39:56 -0500
Date: Wed, 19 Feb 2003 10:49:39 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephen Wille Padnos <stephen.willepadnos@verizon.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: a really annoying feature of the config menu structure
Message-ID: <20030219094939.GB10698@louise.pinerecords.com>
References: <1045623798.25795.73.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0302182110070.25342-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302182110070.25342-100000@dell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [rpjday@mindspring.com]
> 
> > > It seems that the mjpeg stuff will be in the wrong place when it starts 
> > > being used by non-DVB modules.  I see the two (DVB and mjpeg) as 
> > > distinct entities - like ethernet drivers and ipv4.  (DVB drivers should 
> > > let you change channels and whatnot, mjpeg drivers should allow you to 
> > > decode data streams from any available source.)
> > 
> > Its more by API than by hardware. One driver sometimes covers cards with
> > and without tuners, with and without mpeg hardware and so on. Classification
> > is nice, but like biology its never neat
> 
> true enough -- there's no perfect solution, but i'm convinced that
> it can certainly be much more intuitive and organized that it is now.

Please wait until Roman Zippel pushes the "menuconfig" grammar extension.

-- 
Tomas Szepe <szepe@pinerecords.com>
