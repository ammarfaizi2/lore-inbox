Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314505AbSEBO1T>; Thu, 2 May 2002 10:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314516AbSEBO1S>; Thu, 2 May 2002 10:27:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28939 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314505AbSEBO1R>; Thu, 2 May 2002 10:27:17 -0400
Subject: Re: AMD PowerNow booboo in 2.4.19-pre7-ac3
To: davej@suse.de (Dave Jones)
Date: Thu, 2 May 2002 15:20:40 +0100 (BST)
Cc: rmk@arm.linux.org.uk (Russell King), cat@zip.com.au (CaT),
        linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
In-Reply-To: <20020502152502.I16935@suse.de> from "Dave Jones" at May 02, 2002 03:25:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173HRo-0003zz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Odd, Alan must have merged an old version of the cvs tree, as the
> initcalls were nuked a long time ago there iirc. They're certainly not
> in my copy of the current tree

I merged head at the time of the merge, and told you about the initcalls
when I merged them 8). It does need updating especially now spudstop support
is in
