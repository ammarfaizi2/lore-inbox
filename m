Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311135AbSCLNWV>; Tue, 12 Mar 2002 08:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311043AbSCLNWM>; Tue, 12 Mar 2002 08:22:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55301 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311166AbSCLNWG>; Tue, 12 Mar 2002 08:22:06 -0500
Subject: Re: Linux 2.4.19-pre3
To: knweiss@gmx.de (Karsten Weiss)
Date: Tue, 12 Mar 2002 13:37:40 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.44.0203121351070.3320-100000@addx.localnet> from "Karsten Weiss" at Mar 12, 2002 02:01:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kmTE-0003gn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I=B4m surprised that there are no descriptions for the following
> config options (after months of fights for inclusion of this
> patch):
> 
> CONFIG_IDEDISK_STROKE
> CONFIG_IDE_TASK_IOCTL
> CONFIG_BLK_DEV_IDEDMA_FORCED
> CONFIG_IDEDMA_ONLYDISK
> CONFIG_BLK_DEV_ELEVATOR_NOOP
> 
> Or did you simply forget to merge them?

I haven't extracted them and sent them yet - blame me not Marcelo
