Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbTH1NpA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264023AbTH1No7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:44:59 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:8708 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264019AbTH1No5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:44:57 -0400
Date: Thu, 28 Aug 2003 15:44:54 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: usb-storage: how to ruin your hardware(?)
Message-ID: <20030828154454.A2343@pclin040.win.tue.nl>
References: <Pine.LNX.4.53.0308271123480.659@chaos> <200308280259.h7S2xFKV031299@wildsau.idv.uni.linz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308280259.h7S2xFKV031299@wildsau.idv.uni.linz.at>; from kernel@wildsau.idv.uni.linz.at on Thu, Aug 28, 2003 at 04:59:14AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28, 2003 at 04:59:14AM +0200, H.Rosmanith (Kernel Mailing List) wrote:

> the contradiction to this is that the flashdisk can be used
> in a "partition-less" state where it is possible to use the
> whole device at one: "mke2fs /dev/sdb". you have to use the
> vendor formating-tool to make the flashdisk look like an USB_FDD
> device. but even in USB_HDD mode with partitions, the partitions
> still look strange, not ending on cylinder boundaries and so on.

I have seen several posts from you, but all in this vague, almost
information-free style.

It would be of interest if you described your actions and the results
in detail. Or if you gave explicitly the partition table that you
consider strange.

[If you only think about cylinder boundaries: cylinders do not exist,
and cylinder boundaries do not exist either. So that in itself does
not mean a thing.]

Andries

