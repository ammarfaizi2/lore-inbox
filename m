Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268957AbRHFTfC>; Mon, 6 Aug 2001 15:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268959AbRHFTex>; Mon, 6 Aug 2001 15:34:53 -0400
Received: from pD903CA5A.dip.t-dialin.net ([217.3.202.90]:52745 "HELO
	no-maam.dyndns.org") by vger.kernel.org with SMTP
	id <S268957AbRHFTes>; Mon, 6 Aug 2001 15:34:48 -0400
Date: Mon, 6 Aug 2001 21:34:38 +0200
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gateway wireless networking
Message-ID: <20010806213438.C1273@no-maam.dyndns.org>
In-Reply-To: <996980278.8431.6.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996980278.8431.6.camel@tiger>
User-Agent: Mutt/1.3.18i
From: erik.tews@gmx.net (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2001 at 10:57:56PM -0400, Louis Garcia wrote:
> 
> I'm interested in a new laptop with this technology, I think its a
> pcmcia 10/100Mbit card. Does the kernel support this device, or any
> device like it?

I think you want wireless networking how it is defined in IEEE 802.11b.
The maximum theoretical speed is 11 MBit. In normal Enviroments you get
about 600 kbs on a tcp-connection.

Now a lot of companies are producing such cards. I like lucent most.
They seem to be very good manufactured (have never seen a damanged card,
much better than these normal pcmcia-ethernet-cards with external
cable-connector) and multiple drivers exist for linux at the moment (but
I think they work well on BSD too).

Some companies build these cards directly into a laptop (have seen a mac
with a buildin card). But I do not know what Compaq builts into their
laptops. But I you only want good wireless networking, you can but a
laptop with a pcmcia-slot (ok, I think every laptop has this now) and
buy the card seperatly.
