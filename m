Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312075AbSCQRJV>; Sun, 17 Mar 2002 12:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312076AbSCQRJL>; Sun, 17 Mar 2002 12:09:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1811 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312075AbSCQRJC>; Sun, 17 Mar 2002 12:09:02 -0500
Subject: Re: [Announcement] patch-2.0.40-rc4
To: tao@acc.umu.se (David Weinehall)
Date: Sun, 17 Mar 2002 17:24:57 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel Mailing List)
In-Reply-To: <20020317135322.J3301@khan.acc.umu.se> from "David Weinehall" at Mar 17, 2002 01:53:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16meOv-0002xY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o	Commented out a printk in fs/buffer.c   (Michael Deutschmann)
> 	that complains about mismatching
> 	blocksizes

Erm.. why ?? It seems to be correctly complaining for a reason
