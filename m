Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261628AbSI0Ewr>; Fri, 27 Sep 2002 00:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261629AbSI0Ewr>; Fri, 27 Sep 2002 00:52:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49164 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261628AbSI0Ewr>; Fri, 27 Sep 2002 00:52:47 -0400
Date: Thu, 26 Sep 2002 21:45:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Larry Kessler <kessler@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAIDdevice
  driver
In-Reply-To: <3D93C22F.9070006@pobox.com>
Message-ID: <Pine.LNX.4.44.0209262140380.1655-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Sep 2002, Jeff Garzik wrote:
>
> Linus Torvalds wrote:
> > For 2.6.x I care about getting the drivers _working_.
> 
> Tangent question, is it definitely to be named 2.6?

I see no real reason to call it 3.0.

The order-of-magnitude threading improvements might just come closest to
being a "new thing", but yeah, I still consider it 2.6.x. We don't have 
new architectures or other really fundamental stuff. In many ways the jump 
from 2.2 -> 2.4 was bigger than the 2.4 -> 2.6 thing will be, I suspect.

But hey, it's just a number.  I don't feel that strongly either way. I 
think version number inflation (can anybody say "distribution makers"?) is 
a bit silly, and the way the kernel numbering works there is no reason to 
bump the major number for regular releases.

			Linus

