Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131555AbRDBXcv>; Mon, 2 Apr 2001 19:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131496AbRDBXcn>; Mon, 2 Apr 2001 19:32:43 -0400
Received: from waste.org ([209.173.204.2]:9833 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S131555AbRDBXca>;
	Mon, 2 Apr 2001 19:32:30 -0400
Date: Mon, 2 Apr 2001 18:31:47 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <3AC90A1B.3B5DACD1@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0104021825330.29801-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2001, Jeff Garzik wrote:

> Oliver Xymoron wrote:
> > On Mon, 2 Apr 2001, Tom Leete wrote:
> > > How about /lib/modules/$(uname -r)/build/.config ? It's already there.
>
> > It'd be great if we got away from the config being hidden too.
>
> When exporting it outside the kernel tree, the '.' prefix should
> definitely be stripped...

I think the same should be true for the new build system as well.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

