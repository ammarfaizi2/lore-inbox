Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269718AbRHXGhT>; Fri, 24 Aug 2001 02:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269739AbRHXGhJ>; Fri, 24 Aug 2001 02:37:09 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:1798 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S269718AbRHXGgw>; Fri, 24 Aug 2001 02:36:52 -0400
Date: Fri, 24 Aug 2001 08:39:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>, lse-tech@lists.sourceforge.net,
        "Leonard N. Zubkoff" <lnz@dandelion.com>, arjanv@redhat.com
Subject: Re: [patch] PCI64 + block zero-bounce highmem v11
Message-ID: <20010824083950.B4064@suse.de>
In-Reply-To: <20010823095324.Q604@suse.de> <E15Zu1D-0003mT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15Zu1D-0003mT-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23 2001, Alan Cox wrote:
> > I'll include I2O highmem support in the next release -- haven't started
> > it yet, but it should be a breeze.
> 
> It should be, however the amount of i2o firmware that gets 64bit right is
> unknown and I fear quite minimal.

Probably, however just getting 4GB right would be a really good start.

-- 
Jens Axboe

