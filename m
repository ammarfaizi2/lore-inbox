Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129891AbQJZVFN>; Thu, 26 Oct 2000 17:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129889AbQJZVFD>; Thu, 26 Oct 2000 17:05:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29004 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129877AbQJZVEs>; Thu, 26 Oct 2000 17:04:48 -0400
Subject: Re: AMD CPU misdetection?
To: mharris@opensourceadvocate.org (Mike A. Harris)
Date: Thu, 26 Oct 2000 22:05:33 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel mailing list)
In-Reply-To: <Pine.LNX.4.21.0010190048460.859-100000@asdf.capslock.lan> from "Mike A. Harris" at Oct 19, 2000 12:50:24 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13ouDP-0003qS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cpu family      : 5
> model           : 8
> model name      : AMD-K6(tm) 3D processor
>                   ^^^^^^
> 
> Shouldn't it be K6-2?

We report what AMD report
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
