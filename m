Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbTA1Rkk>; Tue, 28 Jan 2003 12:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267459AbTA1Rkk>; Tue, 28 Jan 2003 12:40:40 -0500
Received: from boo-mda02.boo.net ([216.200.67.22]:38161 "EHLO
	boo-mda02.boo.net") by vger.kernel.org with ESMTP
	id <S267457AbTA1Rki>; Tue, 28 Jan 2003 12:40:38 -0500
Message-Id: <200301281749.MAA12566@boo-mda02.boo.net>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: jasonp@boo.net
Subject: Re: [PATCH] page coloring for 2.5.59 kernel, version 1
Date: Tue, 28 Jan 2003 17:49:37 GMT
X-Mailer: Endymion MailMan Standard Edition v3.0.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If a benefit cannot be show on some sort of semi-realistic workload,
> it's probably not worth it, IMHO.

With the present state of the patch my own limited tests don't uncover any
speedups at all on my x86 test machine. For the Alpha with 2MB cache (and the 
2.4 patch) there are measurable speedups; number-crunching benchmarks show it 
the most.

jasonp

---------------------------------------------
This message was sent using Endymion MailMan.
http://www.endymion.com/products/mailman/


