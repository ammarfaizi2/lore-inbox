Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbRANB07>; Sat, 13 Jan 2001 20:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131124AbRANB0t>; Sat, 13 Jan 2001 20:26:49 -0500
Received: from hera.cwi.nl ([192.16.191.1]:18382 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129998AbRANB0n>;
	Sat, 13 Jan 2001 20:26:43 -0500
Date: Sun, 14 Jan 2001 02:26:40 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101140126.CAA114484.aeb@ark.cwi.nl>
To: imel96@trustix.co.id
Subject: Re: [PATCH] plan9 partition support
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the patch locates partitions inside the plan9

> i can't find anyone with plan9 to test,

I'll have a look.
A week ago you sent almost the same patch.
Was there a reason to change __u32 into unsigned long?

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
