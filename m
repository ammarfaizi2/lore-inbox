Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318776AbSHLRt0>; Mon, 12 Aug 2002 13:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318778AbSHLRt0>; Mon, 12 Aug 2002 13:49:26 -0400
Received: from adsl-065-081-088-228.sip.cha.bellsouth.net ([65.81.88.228]:12804
	"EHLO akasha.kan") by vger.kernel.org with ESMTP id <S318776AbSHLRtY>;
	Mon, 12 Aug 2002 13:49:24 -0400
Date: Mon, 12 Aug 2002 13:53:14 -0400 (EDT)
From: k0rd <k0rd@mindwaynetworks.com>
X-X-Sender: k0rd@akasha.kan
To: linux-kernel@vger.kernel.org
Subject: Re: statistics for aliased interfaces? (fwd)
Message-ID: <Pine.LNX.4.44.0208121352550.16518-100000@akasha.kan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded message ----------
Date: Mon, 12 Aug 2002 13:52:15 -0400 (EDT)
From: k0rd <k0rd@mindwaynetworks.com>
To: henrique <henrique@cyclades.com>
Subject: Re: statistics for aliased interfaces?

On Mon, 12 Aug 2002, henrique wrote:

thanks for your help henrique.. does anyone have any hints on where to 
start? i'm not too familiar with the kernel source..

--
k0rd


> Sorry K0rd !!
> 
> I've confused aliases with virtual interfaces. Virtual interface (as ipsec0) 
> have statistic counters but aliases have not.
> 
> The only suggestion I can give is to look on the kernel source code to 
> discover how the kernel treat aliases. Then you can put this information on 
> the /proc directory.
> 
> regards
> Henrique
> 
> 
> On Monday 12 August 2002 05:12 pm, k0rd wrote:
> > hi henrique.
> > what kernel version started including statistics for ethx:x? my ifconfig
> > does not show tx/rx information for these interfaces.
> 
> 


