Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275632AbRIZVjh>; Wed, 26 Sep 2001 17:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275634AbRIZVj1>; Wed, 26 Sep 2001 17:39:27 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:64530
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S275632AbRIZVjL>; Wed, 26 Sep 2001 17:39:11 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200109262120.f8QLKup06335@www.hockin.org>
Subject: Re: Specifying PCI bus speed?
To: swsnyder@home.com
Date: Wed, 26 Sep 2001 14:20:55 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <01092616253900.03354@mercury.snydernet.lan> from "Steve Snyder" at Sep 26, 2001 04:25:39 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it possible to specify the speed of a PCI bus?  I've got a Dell notebook
> machine that drives the bus at 60MHz (rather than the typical 66MHz). 
> 
> I know one can specify the speed of the IDE bus and I'm wondering of there 
> is something analogous for PCI.  Is there?

I have posted a patch for that - I hope it gets accepted some time soon.
If you dig through lkml archives you'll find it.  I'll be making new 2.4.10
patches Real Soon Now, and this will be included.

Tim
