Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132180AbQKSCVM>; Sat, 18 Nov 2000 21:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132004AbQKSCVC>; Sat, 18 Nov 2000 21:21:02 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:30212 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S132191AbQKSCUo>; Sat, 18 Nov 2000 21:20:44 -0500
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: [PATCH] megaraid driver update for 2.4.0-test10
Date: 19 Nov 2000 01:50:56 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8v7bm0$hm5$1@enterprise.cistron.net>
In-Reply-To: <3A170A06.934405FC@evision-ventures.com>
X-Trace: enterprise.cistron.net 974598656 18117 195.64.65.201 (19 Nov 2000 01:50:56 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A170A06.934405FC@evision-ventures.com>,
dalecki  <dalecki@evision-ventures.com> wrote:
>This is a multi-part message in MIME format.
>1. Merge the most current version (aka: 1.08) of the
>   MegaRAID driver from AMI in to the most current kernel
>   (2.4.0-test10 and friends).

The latest is 1.11a or something. The 1.08 one has *bugs*.
At least if it's the same from the 2.2.18preX series. And even
that one has still patches outstanding because it doesn't work

Mike.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
