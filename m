Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131070AbQK3UGK>; Thu, 30 Nov 2000 15:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131106AbQK3UGA>; Thu, 30 Nov 2000 15:06:00 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:21586 "EHLO
        coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
        id <S131143AbQK3Tqw>; Thu, 30 Nov 2000 14:46:52 -0500
Date: Thu, 30 Nov 2000 14:16:16 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Pls add this driver to the kernel tree !!
In-Reply-To: <200011301803.eAUI3Pu16137@webber.adilger.net>
Message-ID: <Pine.LNX.4.10.10011301414520.18688-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, there is some benefit in leaving the LINUX_VERSION_CODE checks
> there...  If someone wants to back-port the driver to 2.2, this makes it
> much easier.  Also, some people like to maintain a single driver for all
> of the kernel versions, so they don't have to bugfix each driver version.

backports hurt forward progress.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
