Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129439AbRBCBVF>; Fri, 2 Feb 2001 20:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130873AbRBCBU4>; Fri, 2 Feb 2001 20:20:56 -0500
Received: from main.cyclades.com ([209.128.87.2]:8203 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129439AbRBCBUt>;
	Fri, 2 Feb 2001 20:20:49 -0500
Date: Fri, 2 Feb 2001 17:20:31 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18: weird eepro100 msgs
In-Reply-To: <200102022335.f12NZ8F11589@moisil.dev.hydraweb.com>
Message-ID: <Pine.LNX.4.10.10102021719120.3255-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Feb 2001, Ion Badulescu wrote:

> On Fri, 2 Feb 2001 15:01:05 -0800 (PST), Ivan Passos <lists@cyclades.com> wrote:
> 
> > Sometimes when I reboot the system, as soon as the eepro100 module is
> > loaded, I start to get these msgs on the screen:
> > 
> > eth0: card reports no resources.
> > eth0: card reports no RX buffers.
> > eth0: card reports no resources.
> > eth0: card reports no RX buffers.
> > eth0: card reports no resources.
> > eth0: card reports no RX buffers.
> > (...)
> 
> Does the following patch, taken from 2.4.1, help?

I'm currently testing. I'll get back to you soon (have to reboot the
system a lot to make sure it's really solved ... :)).

Thanks for the quick response!!

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
