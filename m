Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130243AbRCBBci>; Thu, 1 Mar 2001 20:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130269AbRCBBc3>; Thu, 1 Mar 2001 20:32:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63249 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130243AbRCBBcP>; Thu, 1 Mar 2001 20:32:15 -0500
Subject: Re: 2.4.x very unstable on 8-way IBM 8500R
To: kernel@blackhole.compendium-tech.com (Dr. Kelsey Hudson)
Date: Fri, 2 Mar 2001 01:34:47 +0000 (GMT)
Cc: panu.matilainen@nokia.com ("Matilainen Panu (NRC/Helsinki)"),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103011701360.8542-100000@sol.compendium-tech.com> from "Dr. Kelsey Hudson" at Mar 01, 2001 05:04:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YeT4-0000ej-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > (from Red Hat 7) but very erratic on all 2.4-kernels I've tried it with
> > (2.4.[012], compiled both with egcs and RH7's gcc-2.96, both share the
                                   ^^^^

> Under redhat 7 you should use kgcc to compile the kernel, since gcc2.96 is

So he was using egcs, and whether he had the pre-errata gcc 2.96 wouldnt matter

