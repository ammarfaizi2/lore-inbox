Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264091AbRFNVmW>; Thu, 14 Jun 2001 17:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264089AbRFNVmR>; Thu, 14 Jun 2001 17:42:17 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:49571 "EHLO
	mx01-a.netapp.com") by vger.kernel.org with ESMTP
	id <S264086AbRFNVlQ>; Thu, 14 Jun 2001 17:41:16 -0400
Date: Thu, 14 Jun 2001 14:40:31 -0700 (PDT)
From: Kip Macy <kmacy@netapp.com>
To: "David S. Miller" <davem@redhat.com>
cc: nick@snowman.net, Kip Macy <kmacy@netapp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
In-Reply-To: <15145.11935.992736.767777@pizda.ninka.net>
Message-ID: <Pine.GSO.4.10.10106141439040.6619-100000@orbit-fe.eng.netapp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The acenic is definitely a kick-ass card. One's natural
inclination is to assume that an interface is obscured because 
it is second rate.
		-Kip

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

