Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129118AbQKAFJk>; Wed, 1 Nov 2000 00:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129063AbQKAFJa>; Wed, 1 Nov 2000 00:09:30 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:19300
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S129118AbQKAFJU>; Wed, 1 Nov 2000 00:09:20 -0500
Date: Tue, 31 Oct 2000 21:09:18 -0800
From: Larry McVoy <lm@bitmover.com>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, mingo@elte.hu,
        Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001031210918.A29536@work.bitmover.com>
Mail-Followup-To: Peter Samuelson <peter@cadcamlab.org>,
	"Jeff V. Merkey" <jmerkey@timpanogas.org>, mingo@elte.hu,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011010010380.16674-100000@elte.hu> <39FF4773.CA06CB60@timpanogas.org> <20001031230120.G1041@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <20001031230120.G1041@wire.cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 11:01:20PM -0600, Peter Samuelson wrote:
> So the real question is, how many gettimeofday() per sec can Linux do?

Oh, about 3,531,073 on a 1Ghz AM thunderbird running 
Linux disks.bitmover.com 2.4.0-test5.

That's 283.2 nanoseconds per call, to save you the math.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
