Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbUDQKHT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 06:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbUDQKGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 06:06:48 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:21772 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263813AbUDQKGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 06:06:39 -0400
Date: Sat, 17 Apr 2004 12:06:30 +0200
From: Willy Tarreau <w@w.ods.org>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux on UltraSparcII E450
Message-ID: <20040417100630.GG596@alpha.home.local>
References: <20040417105303.7936e413@vaio.gigerstyle.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417105303.7936e413@vaio.gigerstyle.ch>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm, I believe you forgot to tell which kernel version you used, and how
you configured it :-)

Willy

On Sat, Apr 17, 2004 at 10:53:03AM +0200, Marc Giger wrote:
> Hi All,
> 
> Last week I had the honor to install Linux on a E450 with 2 cpu's. All
> went fine at first. Long compiling sessions were no problem for the
> machine. Later we installed 16 additional SCSI disks and we built 
> 4 x Soft-RAID5 groups with 4 disks each.
> After some time during the sync processes the machine stops responding.
> Simply dead. The same thing happens after every boot when the sync
> process is in action.
> 
> My question now is: Is it a hardware or a kernel problem? I now it isn't
> a simple question with the given infos.
> Is it possible that the 4 parallel sync processes are to much for the
> SCSI (standard LSI) controllers?
> I assume that the kernel RAID5 code is stable on sparc?!
> 
> Thank you
> 
> Regards
> 
> Marc
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
