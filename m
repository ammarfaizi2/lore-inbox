Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280907AbRKCBIH>; Fri, 2 Nov 2001 20:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280908AbRKCBH5>; Fri, 2 Nov 2001 20:07:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16907 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280907AbRKCBHv>; Fri, 2 Nov 2001 20:07:51 -0500
Subject: Re: Annoying msgs about hda
To: lists@cyclades.com (Ivan Passos)
Date: Sat, 3 Nov 2001 01:14:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.LNX.4.30.0111021629480.742-100000@intra.cyclades.com> from "Ivan Passos" at Nov 02, 2001 04:51:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15zpOS-0004Dr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> linux/fs/partitions/check.c), but it's really annoying to get these msgs
> every time I mount the device!!
> 
> Is there a way to prevent this?!?! Or ... why doesn't it happen on a
> "regular" distro (like my Debian system)??

I believe the debian folks (as with currentish kernels) mark that down
as KERN_DEBUG
