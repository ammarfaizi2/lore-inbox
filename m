Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264084AbRFNVkn>; Thu, 14 Jun 2001 17:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264083AbRFNVkj>; Thu, 14 Jun 2001 17:40:39 -0400
Received: from ns.snowman.net ([63.80.4.34]:51471 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S264084AbRFNVkY>;
	Thu, 14 Jun 2001 17:40:24 -0400
Date: Thu, 14 Jun 2001 17:40:11 -0400 (EDT)
From: <nick@snowman.net>
To: "David S. Miller" <davem@redhat.com>
cc: Kip Macy <kmacy@netapp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
In-Reply-To: <15145.11935.992736.767777@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0106141739140.16013-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So are there any intresting changes one can make to the acenic?  I've got
one, mostly unused right now.  I've been told it is mostly a pair or R5ks
hooked back to back.  Would anyone have a recommendation for a replacement
to the 3cr990?
	Nick

On Thu, 14 Jun 2001, David S. Miller wrote:

> 
> nick@snowman.net writes:
>  > Erm, that is going to be a problem.  Crypto benifits more from open source
>  > than any other market segment, and binary only drivers for linux are not
>  > the way to go.  I guess I need to get rid of my 5-10 3cr990s and replace
>  > them with someone else's product?
> 
> Many of us on the networking developer team believe that making the
> programming interface to the cpus on the Tigon3 is the biggest mistake
> 3com could ever make.
> 
> What made the Acenic so ubiquitous and interesting was that you could
> program the firmware on the board to do whatever you like.  They even
> provided an entire firmware developer kit so you could hack on it.
> 
> So many useful projects came from this capability.
> 
> I feel dirty working on the Tigon3 driver for 2.4.x because of this.
> 
> Later,
> David S. Miller
> davem@redhat.com
> 

