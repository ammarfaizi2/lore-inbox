Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278218AbRJ1MHI>; Sun, 28 Oct 2001 07:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278215AbRJ1MG7>; Sun, 28 Oct 2001 07:06:59 -0500
Received: from pc1-camb5-0-cust171.cam.cable.ntl.com ([62.253.134.171]:31380
	"EHLO fenrus.demon.nl") by vger.kernel.org with ESMTP
	id <S278216AbRJ1MGu>; Sun, 28 Oct 2001 07:06:50 -0500
From: arjan@fenrus.demon.nl
To: linux-kernel@vger.kernel.org
Subject: Re: Is Promise FastTrak 100 RAID1 + Linux now possible? (CONFIG_BLK_DEV_ATARAID_PDC)
In-Reply-To: <007f01c15fa7$e8d784a0$0100005a@host1>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E15xoiC-0004Dx-00@fenrus.demon.nl>
Date: Sun, 28 Oct 2001 12:06:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <007f01c15fa7$e8d784a0$0100005a@host1> you wrote:
> well, promise still didnt release any decent drivers but i saw "Support for
> IDE Raid controllers" (CONFIG_BLK_DEV_ATARAID) and "Support Promise software
> RAID (Fasttrak(tm))" (CONFIG_BLK_DEV_ATARAID_PDC) appearing in 2.4.1x (where
> x>10 and x<13 i think) recently.....but they are still undocumented of
> course...so could anyone please give me information on them? do they make
> fasttrak 100 raid1 possible?

RAID1 is very experimental and not complete; RAID0 is working pretty well.
See http://people.redhat.com/arjanv/pdcraid for more info
