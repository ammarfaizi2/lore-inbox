Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317551AbSGEUSx>; Fri, 5 Jul 2002 16:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317552AbSGEUSw>; Fri, 5 Jul 2002 16:18:52 -0400
Received: from molly.vabo.cz ([160.216.153.99]:54023 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id <S317551AbSGEUSv>;
	Fri, 5 Jul 2002 16:18:51 -0400
Date: Fri, 5 Jul 2002 22:21:19 +0200 (CEST)
From: Tomas Konir <moje@molly.vabo.cz>
X-X-Sender: moje@moje.ich.vabo.cz
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM Desktar disk problem?
In-Reply-To: <20020705201155.GF28569@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.44L0.0207052216410.3293-100000@moje.ich.vabo.cz>
References: <Pine.LNX.4.43.0207051524480.9092-100000@cibs9.sns.it>
 <Pine.LNX.4.44L0.0207051606050.32493-100000@moje.ich.vabo.cz>
 <20020705201155.GF28569@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002, Matthias Andree wrote:

> On Fri, 05 Jul 2002, Tomas Konir wrote:
> 
> > hi i have similar problem.
> > No dead disks, but after two days testing tcq patches (on 2.4). I 
> > got the two ATA errors (smartctl said). 
> 
> *shrug* FreeBSD should have eaten some of those drives as well, it has
> been offering hw.ata.tags="1" to enable DMA QUEUED for a while now.
> 
> And yes, my deathstar DTLA307045 still works without a single broken
> block, but never used TCQ beyond booting 2.5.17 once (no LVM -> not
> useful for me).
> 
> Another DTLA307045 died some days ago, it has never seen TCQ.
> 

I have no broken blocks. Only two errors logged in S.M.A.R.T.
I have no S.M.A.R.T. errors for one year ago. And after use TCQ there are 
two errors after two days. Is is normal ?
Curently i not believe new IBM disks and TCQ. I'll wait for better disks 
and stable TCQ.

	MOJE

-- 
Tomas Konir
Brno
ICQ 25849167


