Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSJIQqe>; Wed, 9 Oct 2002 12:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261871AbSJIQqe>; Wed, 9 Oct 2002 12:46:34 -0400
Received: from franka.aracnet.com ([216.99.193.44]:62638 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261868AbSJIQqc>; Wed, 9 Oct 2002 12:46:32 -0400
Date: Wed, 09 Oct 2002 09:49:43 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  October 9, 2002
Message-ID: <1545611972.1034156982@[10.10.2.3]>
In-Reply-To: <3DA41B88.14599.2336B580@localhost>
References: <3DA41B88.14599.2336B580@localhost>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o Beta  Page table sharing  (Daniel Phillips, Dave McCracken)  

I'd say this is "ready" state now.

> o Alpha  NUMA aware scheduler extensions  (Erich Focht)  

Beta.

> o Alpha  Non-linear memory support  (Martin Bligh, Daniel Phillips)  

Drop this, I don't think it'll make it in time. I ended up spreading
the mem-map array across nodes by hand for 32 bit machines.

> o Started  NUMA aware slab allocator  (Martin Bligh)  

Alpha, and it's Manfred Spraul doing most of the real work on
this now ;-)

> o Started  SCSI multipath IO (with NUMA support)  (Patrick Mansfield, Mike Anderson)  

Beta.

> Cleanups:  

There's been a lot of discontigmem cleanup over the 2.5.3x timeframe
by both myself and Christoph.

Thanks,

M.
