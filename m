Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290877AbSARX1B>; Fri, 18 Jan 2002 18:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290876AbSARX0t>; Fri, 18 Jan 2002 18:26:49 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:34691 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S290872AbSARX0i>; Fri, 18 Jan 2002 18:26:38 -0500
Date: Fri, 18 Jan 2002 17:26:34 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.16
Message-ID: <20020118172634.C31076@asooo.flowerfire.com>
In-Reply-To: <3C3E7F89.AB2F629@zip.com.au> <1011395469.850.8.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1011395469.850.8.camel@phantasy>; from rml@tech9.net on Fri, Jan 18, 2002 at 06:10:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same on 2-way 1GB and 6-way 4GB boxes where I could easily reproduce one
of the issues.

-- 
Ken.
brownfld@irridia.com


On Fri, Jan 18, 2002 at 06:10:29PM -0500, Robert Love wrote:
| On Fri, 2002-01-11 at 01:00, Andrew Morton wrote:
| > A small ext3 update.  It fixes a few hard-to-hit but potentially
| > serious problems.  The patch is against 2.4.18-pre3, and is also
| > applicable to 2.4.17.
| 
| I didn't see any feedback so I wanted to confirm success on my
| 2.4.18-pre4 UP machine.  Survived prolonged use and some initial
| stressing.  Good job.
| 
| 	Robert Love
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
