Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIQhq>; Tue, 9 Jan 2001 11:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRAIQhg>; Tue, 9 Jan 2001 11:37:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45580 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129383AbRAIQhV>; Tue, 9 Jan 2001 11:37:21 -0500
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
To: mingo@elte.hu
Date: Tue, 9 Jan 2001 16:37:32 +0000 (GMT)
Cc: sct@redhat.com (Stephen C. Tweedie), hch@caldera.de (Christoph Hellwig),
        davem@redhat.com (David S. Miller), riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101091641180.4491-100000@e2> from "Ingo Molnar" at Jan 09, 2001 05:16:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14G1mB-0006vF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We have already shown that the IO-plugging API sucks, I'm afraid.
> 
> it might not be important to others, but we do hold one particular
> SPECweb99 world record: on 2-way, 2 GB RAM, testing a load with a full

And its real world value is exactly the same as the mindcraft NT values. Don't
forget that.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
