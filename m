Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276486AbRI2MOw>; Sat, 29 Sep 2001 08:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276487AbRI2MOm>; Sat, 29 Sep 2001 08:14:42 -0400
Received: from mx2.utanet.at ([195.70.253.46]:35555 "EHLO smtp1.utaiop.at")
	by vger.kernel.org with ESMTP id <S276486AbRI2MO2>;
	Sat, 29 Sep 2001 08:14:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gerold Jury <gjury@hal.grips.com>
Organization: Grips
To: Steve Lord <lord@sgi.com>
Subject: Re: [BENCH] Problems with IO throughput and fairness with 2.4.10 and 2.4.9-ac15
Date: Sat, 29 Sep 2001 16:13:59 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200109281758.f8SHwCW21849@jen.americas.sgi.com>
In-Reply-To: <200109281758.f8SHwCW21849@jen.americas.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010929121437Z276486-760+18495@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 September 2001 19:58, Steve Lord wrote:
> Hi,
>
> Can you try XFS with this change, just to confirm you are seeing the same
> problem I am seeing. I am not proposing this as a permanent fix yet,
> just confirming what the deadlock is.
>
> Thanks
>
>    Steve
>
The deadlock is gone. dbench 32 gives me
Throughput 1.55412 MB/sec (NB=1.94265 MB/sec  15.5412 MBit/sec)  32 procs
with 2.4.10-xfs + your patch

I will leave it this way.

Unfortunately i have a buissnes trip to South Afrika for at least 8 days 
starting tomorrow. I will not be able to do any further testing until then.

Thanks
Gerold
