Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283512AbRK3F6P>; Fri, 30 Nov 2001 00:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283514AbRK3F6F>; Fri, 30 Nov 2001 00:58:05 -0500
Received: from [208.48.139.185] ([208.48.139.185]:3553 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S283512AbRK3F5w>; Fri, 30 Nov 2001 00:57:52 -0500
Date: Thu, 29 Nov 2001 21:57:46 -0800
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 freezed up with eepro100 module
Message-ID: <20011129215746.A29355@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <15366.21354.879039.718967@abasin.nj.nec.com> <20011129095107.A17457@conwaycorp.net> <3C070FEC.3602CB49@pobox.com> <20011130114506.A4789@bee.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011130114506.A4789@bee.lk>; from anuradha@gnu.org on Fri, Nov 30, 2001 at 11:45:06AM +0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 11:45:06AM +0600, Anuradha Ratnaweera wrote:
> 
> Has anybody got the same issue with non Dell machines?
> 
> I am running 2.4.16 on a Compaq proliant ML 370 without problems (machine has
> been up for 2+ days with the new kernels, though).  Trafic is not very high.

I don't have any non-Dell machines with the eepro100, but I did put one of
our Dells on 2.2.16 35 hours ago with the eepro100 driver.  I don't know the
exact model, but it's an older dual 500MHz PIII machine.  Traffic is light,
with only appoximately 100MB being transfered over the network so far.

Is there a workload that can reproduce the hang?  If so, I might be able to
do a bit of testing...

I've also got a couple Dell 2400s, but those are still running 2.4.9. 
Unfortunately those are production machines, so I don't want to mess with
them right now.

-Dave
