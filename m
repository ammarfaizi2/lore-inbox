Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130503AbRCFLmF>; Tue, 6 Mar 2001 06:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130519AbRCFLlz>; Tue, 6 Mar 2001 06:41:55 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44808 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130503AbRCFLlp>; Tue, 6 Mar 2001 06:41:45 -0500
Subject: Re: Kernel 2.4.3 and new aic7xxx
To: raffo@neuronet.pitt.edu (Rafael E. Herrera)
Date: Tue, 6 Mar 2001 11:44:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (LK)
In-Reply-To: <3AA470C6.1A2BD379@neuronet.pitt.edu> from "Rafael E. Herrera" at Mar 06, 2001 12:08:22 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14aFte-0000W7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> from devices in channel B. I boot from  a disk connected to channel B
> and when the kernel loads the driver the disks from channel A are seen
> first, resulting in the drive names changing from, say sda to sdb. This
> does not happen with 2.2.18 or 2.4.2. Is there an option to reverse the
> order? I saw some of the options in the code, but none about this.

at the moment the option to reverse the order is called using the old driver.
