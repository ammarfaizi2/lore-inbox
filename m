Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132698AbRDQOyQ>; Tue, 17 Apr 2001 10:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132696AbRDQOyG>; Tue, 17 Apr 2001 10:54:06 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:17302 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S132697AbRDQOx1>;
	Tue, 17 Apr 2001 10:53:27 -0400
Date: Tue, 17 Apr 2001 16:53:01 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Andi Kleen <ak@suse.de>
cc: Eric Weigle <ehw@lanl.gov>, Sampsa Ranta <sampsa@netsonic.fi>,
        linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
        zebra@zebra.org
Subject: Re: ARP responses broken!
In-Reply-To: <20010417161919.A8842@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0104171652360.9099-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Andi Kleen wrote:

> On Mon, Apr 16, 2001 at 03:26:19PM -0600, Eric Weigle wrote:
> > Hello-
> > 
> > This is a known 'feature' of the Linux kernel, and can help with load sharing
> > and fault tolerance. However, it can also cause problems (such as when one nic
> > in a multi-nic machine fails and you don't know right away).
> > 
> > There are three 'solutions' I know of:
> > 
> >   * In recent 2.2 kernels, it was possible to fix this by doing the following as
> 
> Or use arpfilter in even newer 2.2 kernels; which filters based on the routing
> table. "hidden" is quite a sledgehammer which often does more harm than good.

Does arpfilter exist in 2.4 kernels?

/Martin

