Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129337AbQKDSRv>; Sat, 4 Nov 2000 13:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129142AbQKDSRl>; Sat, 4 Nov 2000 13:17:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51490 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129118AbQKDSR2>; Sat, 4 Nov 2000 13:17:28 -0500
Subject: Re: processes> 2^15
To: aprasad@in.ibm.com
Date: Sat, 4 Nov 2000 18:18:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <CA25698D.00608C13.00@d73mta05.au.ibm.com> from "aprasad@in.ibm.com" at Nov 04, 2000 07:27:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13s7tk-0004hf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> after reaching process count something around 30568, processes start
> getting pid from start, which ever is the first free entry slot in process
> table. that means we can't have simultaneously more than roughly 2^15
> processes?

Yes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
