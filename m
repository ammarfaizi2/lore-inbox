Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132708AbRDQPH4>; Tue, 17 Apr 2001 11:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132705AbRDQPHr>; Tue, 17 Apr 2001 11:07:47 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:29334 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S132702AbRDQPH3>;
	Tue, 17 Apr 2001 11:07:29 -0400
Date: Tue, 17 Apr 2001 17:07:12 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andi Kleen <ak@suse.de>
cc: Eric Weigle <ehw@lanl.gov>, Sampsa Ranta <sampsa@netsonic.fi>,
        linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
        zebra@zebra.org
Subject: Re: ARP responses broken!
In-Reply-To: <20010417170110.A10430@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0104171703250.9099-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Andi Kleen wrote:

[snip]
> > Does arpfilter exist in 2.4 kernels?
> 
> Not yet, will be merged very soon. I can send you a patch if you need it urgently.

No I don't need it urgently.
I was asking because I had this problem before (router with two cards
against one physical subnet) and arpwatch complained that the router kept
switching MACaddresses all the time.

/Martin

