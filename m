Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132034AbRCVOqK>; Thu, 22 Mar 2001 09:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132037AbRCVOpv>; Thu, 22 Mar 2001 09:45:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2311 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132034AbRCVOpn>; Thu, 22 Mar 2001 09:45:43 -0500
Subject: Re: regression testing
To: root@chaos.analogic.com
Date: Thu, 22 Mar 2001 14:47:18 +0000 (GMT)
Cc: nbecker@fred.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010322083448.20107C-100000@chaos.analogic.com> from "Richard B. Johnson" at Mar 22, 2001 08:39:06 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14g6My-0002dw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Regression testing __is__ what happens when 10,000 testers independently
> try to break the software!

Nope. Thats stress testing and a limited amount of coverage testing.

> Canned so-called "regression-test" schemes will fail to test at least
> 90 percent of the code paths, while attempting to "test" 100 percent
> of the code!

Then they are not well designed. Tools like gprof and the kernel profiling
will let you measure code path coverage of a test series

