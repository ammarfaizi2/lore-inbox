Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129155AbRAaWFq>; Wed, 31 Jan 2001 17:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129194AbRAaWFg>; Wed, 31 Jan 2001 17:05:36 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:12557 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129155AbRAaWFV>;
	Wed, 31 Jan 2001 17:05:21 -0500
Date: Wed, 31 Jan 2001 23:04:28 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: safemode <safemode@voicenet.com>
cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        David Raufeisen <david@fortyoz.org>, Vojtech Pavlik <vojtech@suse.cz>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <3A786F00.B9248616@voicenet.com>
Message-ID: <Pine.LNX.4.30.0101312302410.14538-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, safemode wrote:

> I'm wondering... Perhaps it's a problem motherboard specific.  I'm
> using the KA7 and saw pretty bad problems (extreme fs corruption)
> and bad latency. Perhaps the K7V and the KT7's dont have this problem.
> I dont see any of the problems with dma enabled on 2.2.x

But are you using the same DMA mode in 2.2 as in 2.4?  You can check that
using hdparm -i, I believe.

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
