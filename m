Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262614AbREODtj>; Mon, 14 May 2001 23:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262615AbREODta>; Mon, 14 May 2001 23:49:30 -0400
Received: from cr481834-a.ktchnr1.on.wave.home.com ([24.102.89.11]:42226 "HELO
	scotch.homeip.net") by vger.kernel.org with SMTP id <S262614AbREODt1>;
	Mon, 14 May 2001 23:49:27 -0400
Date: Mon, 14 May 2001 23:49:16 -0400 (EDT)
From: God <atm@sdk.ca>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: TCP capture effect :: estimate queue length ?
In-Reply-To: <20010514234604.A4694@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0105142339470.23642-100000@scotch.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, Andi Kleen wrote:

[.....]

> Packets are dropped when a device queue
> fills, and when one sender is much faster than the other the faster sender
> often wins the race, while the packets of the slower one get dropped.

[.....]

Speaking of queues on routers/servers, does such a util exist that would
measure (even a rough estimate), what level of congestion (queueing) is
happening between point A and B ?  I'd be curious how badly congested some
things upstream from me are......   I know I can use ping or
traceroute ... but they don't report queueing or bursting.  Both measure
latency and packetloss ... short of stareing at a running ping that is
... <G>

