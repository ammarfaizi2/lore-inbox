Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278755AbRKVNMn>; Thu, 22 Nov 2001 08:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279005AbRKVNMd>; Thu, 22 Nov 2001 08:12:33 -0500
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:52484 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S278755AbRKVNMO>;
	Thu, 22 Nov 2001 08:12:14 -0500
Date: Thu, 22 Nov 2001 14:12:06 +0100 (CET)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Anders Linden <anli@perceptive.se>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Network card timeouts
In-Reply-To: <71C83C8929F73A40BBD0C137232DD1972ED4@piff.i.perceptive.se>
Message-ID: <Pine.LNX.4.33.0111221407510.13980-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Anders Linden wrote:

> Occasion 2:
> The later card, Davicom, is probably not a well-known card, but
> nevertheless, it works like shit in Linux. I am using Redhat 7.1 and the
> kernel 2.4.2-2. If I send more than 10M to such a card in an interval of
> a second, it just quits working for 5 seconds. The card has no problems
> at all in other, third party operating systems, like Windows.
> 
> Is it the newest kernels that has theese problems? The first occasion
> was exactly after a kernel 2.4.3 has been released, and people I talked
> to said that 2.4.2 and network cards were better friends.
> 
> Thanks for your attension

Please try 2.4.14 and let me know if you still see this problem with the
dmfe driver.

/Tobias

