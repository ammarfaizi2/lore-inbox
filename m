Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272763AbRILMmz>; Wed, 12 Sep 2001 08:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272766AbRILMmo>; Wed, 12 Sep 2001 08:42:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43274 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272763AbRILMm3>; Wed, 12 Sep 2001 08:42:29 -0400
Subject: Re: Bug still on 2.4.10?
To: mblack@csihq.com (Mike Black)
Date: Wed, 12 Sep 2001 13:47:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <00d301c13b79$56982e20$e1de11cc@csihq.com> from "Mike Black" at Sep 12, 2001 06:54:46 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15h9Q2-0004QR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is on 2.4.8 but I get the funny feeling this maybe hasn't been fixed
> yet for 2.4.10:
> 
> Sep 11 06:58:08 yeti kernel: md: fsck.ext3(pid 151) used obsolete MD
> ioctl(4717), upgrade your software to use new ictls.

This isnt a kernel bug. 

> I'm runing:
> Parallelizing fsck version 1.23 (15-Aug-2001)
> Unless maybe I just need to recompile it???

Back down to 1.22
