Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133093AbRDRMCL>; Wed, 18 Apr 2001 08:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133094AbRDRMCB>; Wed, 18 Apr 2001 08:02:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27909 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133093AbRDRMBq>; Wed, 18 Apr 2001 08:01:46 -0400
Subject: Re: performance degradation on -ac tree
To: jjs@mirai.cx (J Sloan)
Date: Wed, 18 Apr 2001 13:03:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3ADD140E.A4E2974D@mirai.cx> from "J Sloan" at Apr 17, 2001 09:12:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pqgA-0004Yt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have noticed that with e.g. the 2.4.0-test kernels, and e.g.
> 2.4.2, netperf to localhost gets between 350-400 MB/s.
> With recent -ac kernels, e.g. 2.4.3-ac5, netperf to localhost
> gets more like 250 MB/sec.

Thats one to ask Dave Miller.

> The same activity with recent -ac kernels feels like running
> through molasses, very sluggish, and it is I who am repeatedly
> outmaneuvered and embarrassed. It's quite awful.

The 2.4.3ac VM is far from ideal at the moment. Its a lot smoother for server
use and it doesnt spend so much time randomly killing wrong things but it does
stall too much
