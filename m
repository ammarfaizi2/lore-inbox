Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSIZW71>; Thu, 26 Sep 2002 18:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261569AbSIZW70>; Thu, 26 Sep 2002 18:59:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61450 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261568AbSIZW7Z>; Thu, 26 Sep 2002 18:59:25 -0400
Date: Thu, 26 Sep 2002 16:07:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Larry Kessler <kessler@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAIDdevice
  driver
In-Reply-To: <3D93912C.5080704@pobox.com>
Message-ID: <Pine.LNX.4.33.0209261604190.1712-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Sep 2002, Jeff Garzik wrote:
> 
> no need to be mindful of that.
> 
> Let's get it right, rather than rush it...

Which imples that it's 2.7 material.

For 2.6.x I care about getting the drivers _working_.

The whole logging discussion with hardened drivers etc is _not_ adding
value to normal people until much much later, and it sound very much to me
like one of those patch sets that some vendors will care about deeply
because they have some big company that cares and pays them.

Those kinds of patch-sets sometimes never make it into the standard 
kernel. They have to prove their worth to real people first, and I could 
care less (but not much) about paperwork reasons.

		Linus

