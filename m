Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268936AbRHFTLE>; Mon, 6 Aug 2001 15:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbRHFTKy>; Mon, 6 Aug 2001 15:10:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38661 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268936AbRHFTKr>; Mon, 6 Aug 2001 15:10:47 -0400
Subject: Re: MTRR errors at startup... (fwd)
To: root@ria.jamescleland.com (root)
Date: Mon, 6 Aug 2001 20:12:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108061449360.10211-100000@ria.jamescleland.com> from "root" at Aug 06, 2001 03:01:31 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Tpnm-0001bQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Aug  6 04:02:40 valerie kernel: Setting commenced=1, go go go
> Aug  6 04:02:40 valerie kernel: mtrr: your CPUs had inconsistent variable MTRR settings
> Aug  6 04:02:40 valerie kernel: mtrr: probably your BIOS does not setup all CPUs

It indicates your bios authors can't read standards. Thats a quite normal
state of affairs, so common that the kernel cleans up after them

