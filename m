Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269325AbUJFRSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269325AbUJFRSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269310AbUJFRQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:16:50 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:17323 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269286AbUJFRQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:16:31 -0400
Subject: Re: Problem - install scsi adapter and scanner
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jurek Ela Tryjarscy <jurekt@kabatnet.waw.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41618A69.7050706@kabatnet.waw.pl>
References: <41618A69.7050706@kabatnet.waw.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097079242.29251.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 17:14:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-10-04 at 18:37, jurek Ela Tryjarscy wrote:
> Hi ,
> In my box I have Redhat 9.
> I must connect via SCSI Interface Umax Mirage II scanner.
> SCSI adapter is Acard AEC-6712TU.
> 
> System logs contain:
> 
> Oct  4 19:19:05 localhost kernel:    ACARD AEC-671X PCI Ultra/W SCSI-3 
> Host Adapter: 0    IO:1000, IRQ:11.
> Oct  4 19:19:05 localhost kernel:          ID:  7  Host Adapter
> Oct  4 19:19:05 localhost kernel: scsi0 : ACARD AEC-6710/6712/67160 PCI 
> Ultra/W/LVD SCSI-3 Adapter Driver V2.6+ac

The card didn't see the scanner, check your cabling/setup.

Alan

