Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbRGFUjr>; Fri, 6 Jul 2001 16:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266838AbRGFUjh>; Fri, 6 Jul 2001 16:39:37 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:3533 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S266839AbRGFUjZ>;
	Fri, 6 Jul 2001 16:39:25 -0400
Message-Id: <m15IcNe-000OzHC@amadeus.home.nl>
Date: Fri, 6 Jul 2001 21:39:14 +0100 (BST)
From: arjan@fenrus.demon.nl
To: skulcap@mammoth.org (josh)
Subject: Re: funky tyan s2510
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0107061109400.20154-100000@hannibal.mammoth.org>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0107061109400.20154-100000@hannibal.mammoth.org> you wrote:

> I have a tyan s2510 with a single pIII 800Mhz cpu and 1GB of RAM.
> I have been having problems with this system from the get go and
> cant seem to narrow down what the problem is.  I have tried running
> 2.4.6, but the system usually doesnt last more than a day.  With 
> 2.4.2 i get a variety of kernel messages:
> #############################################
> vs-5150: search_by_key: invalid format found in block 0. Fsck?

IDE on a serverworks chipset ? If so try Alan's latest patches for an
updated driver
