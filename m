Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKGGL0>; Tue, 7 Nov 2000 01:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130751AbQKGGLQ>; Tue, 7 Nov 2000 01:11:16 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:22277 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129057AbQKGGLA>; Tue, 7 Nov 2000 01:11:00 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: rdtsc to mili secs?
Date: 6 Nov 2000 22:10:41 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8u86d1$hhc$1@cesium.transmeta.com>
In-Reply-To: <20001106011000.A9787@athlon.random> <E13sa8o-0005jc-00@the-village.bc.nu> <20001106091723.A516@linuxcare.com> <3A078C65.B3C146EC@mira.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A078C65.B3C146EC@mira.net>
By author:    Antony Suter <antony@mira.net>
In newsgroup: linux.dev.kernel
> 
> This issue, and all related issues, need to be taken care of for all
> speed changing CPUs from Intel, AMD and Transmeta. Is the answer of
> "howto write userland programs correctly with a speed changing cpu"
> in a FAQ somewhere?
> 

At least in case of Transmeta, RDTSC will return wall time.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
