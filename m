Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272250AbRHWMw2>; Thu, 23 Aug 2001 08:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272252AbRHWMwS>; Thu, 23 Aug 2001 08:52:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39174 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272250AbRHWMwN>; Thu, 23 Aug 2001 08:52:13 -0400
Subject: Re: [patch] PCI64 + block zero-bounce highmem v11
To: axboe@suse.de (Jens Axboe)
Date: Thu, 23 Aug 2001 13:55:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel),
        davem@redhat.com (David S. Miller), lse-tech@lists.sourceforge.net,
        lnz@dandelion.com (Leonard N. Zubkoff), arjanv@redhat.com
In-Reply-To: <20010823095324.Q604@suse.de> from "Jens Axboe" at Aug 23, 2001 09:53:24 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Zu1D-0003mT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll include I2O highmem support in the next release -- haven't started
> it yet, but it should be a breeze.

It should be, however the amount of i2o firmware that gets 64bit right is
unknown and I fear quite minimal.

Alan
