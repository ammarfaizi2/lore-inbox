Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLAPbR>; Fri, 1 Dec 2000 10:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLAPbH>; Fri, 1 Dec 2000 10:31:07 -0500
Received: from mx7.port.ru ([194.67.23.44]:4028 "EHLO mx7.port.ru")
	by vger.kernel.org with ESMTP id <S129183AbQLAPa6>;
	Fri, 1 Dec 2000 10:30:58 -0500
From: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: DMA !NOT ONLY! for triton again...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 143.167.4.62 via proxy [143.167.1.16]
Reply-To: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E141rfr-0009SD-00@f11.mail.ru>
Date: Fri, 01 Dec 2000 18:00:31 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glad all this discussion helped at least one of us:-))

As for me, as I already mentioned in my last posting - I don't know why BIOS makes the difference (as in your case) if ide.txt says it shouldn't?! Ok, chipset, perhaps, is fine. But what about the hard drive? You told you had WDC AC21600H. Can you PLEASE check waht CCC is marked on its label? PLEASE! I am trying to get an answer from WD on this, but not yet alas...

And - COME ON, GUYS! - somebody MUST know the answer - how to spot the guilty one - kernel configuration / BIOS / chipset / disk???

Guennadi

> back in, started playing in the bios.  Finally fixed it.  I was getting > the same operation not permitted, that you
> were,until i got that bios setting. But it's making me 
> wonder if it's something similar in your bios!
> I know it wasn't the actual UDMA setting in the bios, i'm 
> wondering what it was though.  I'll put a keyboard on it,
> and poke around tonight or this weekend.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
