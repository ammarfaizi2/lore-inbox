Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317153AbSEXOvw>; Fri, 24 May 2002 10:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317154AbSEXOvv>; Fri, 24 May 2002 10:51:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11276 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317153AbSEXOvt>; Fri, 24 May 2002 10:51:49 -0400
Subject: Re: [BUG] 2.4 VM sucks. Again
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Fri, 24 May 2002 16:11:35 +0100 (BST)
Cc: Martin.Bligh@us.ibm.com (Martin J. Bligh), linux-kernel@vger.kernel.org
In-Reply-To: <200205231629.g4NGTWE22956@mail.pronto.tv> from "Roy Sigurd Karlsbakk" at May 23, 2002 06:29:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BGj9-0006VQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > How much RAM do you have, and what does /proc/meminfo
> > and /proc/slabinfo say just before the explosion point?
> 
> I have 1 gig - highmem (not enabled) - 900 megs.
> for what I can see, kernel can't reclaim buffers fast enough.
> ut looks better on -aa.
> 

What sort of setup. I can't duplicate the problem here ?
