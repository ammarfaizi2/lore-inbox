Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143369AbREKTH6>; Fri, 11 May 2001 15:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143368AbREKTHv>; Fri, 11 May 2001 15:07:51 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53004 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143363AbREKTFq>; Fri, 11 May 2001 15:05:46 -0400
Subject: Re: PROBLEM: 2.4.4ac7 oops, locks in init on boot
To: gbsadler1@lcisp.com (Gordon Sadler)
Date: Fri, 11 May 2001 20:02:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010511140019.A1248@debian-home.lcisp.com> from "Gordon Sadler" at May 11, 2001 02:00:19 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yIBC-0001XM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If anyone has any further suggestions/patches to run 2.4.x with K7
> chosen optimizations, I'm open to testing.

'Buy an AMD chipset box..'

Seriously at this point I am out of ideas. The prefetch to far effect 
explained the old athlon locks (step 1) people reported on all chipsets. It
didnt really seem to explain the problem with a few via chipset boards but I
was hopeful. 

Alan

