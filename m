Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131206AbRAWXvS>; Tue, 23 Jan 2001 18:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131847AbRAWXu6>; Tue, 23 Jan 2001 18:50:58 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:61480 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S130163AbRAWXux>;
	Tue, 23 Jan 2001 18:50:53 -0500
Date: Wed, 24 Jan 2001 00:52:57 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Godfrey Livingstone <godfrey@hattaway-associates.com>
Subject: Re: Ingo's RAID patch for 2.2.18 final?
In-Reply-To: <3A61315C.37318059@hattaway-associates.com>
Message-ID: <Pine.LNX.4.30.0101240044040.3522-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2001, Godfrey Livingstone wrote:

> You MUST apply this patch before the two raid patches. The VM patch stablises
> the 2.2.18 virtual memory system and if you don't apply my two repackaged
> patches will fail. The above VM patch has been accepted into 2.2.19pre3 and
> many people are using it so is not untested.

2.2.19preXaaX Virtually disabled I/O cache extention-by-swapout, working
on previous (semi)stock kernels (raid+ide patched) :(

Thus I wouldn't advise VM global till it gets somewhatbalanced to
non-swapless configs...

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
