Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132678AbRDQUtY>; Tue, 17 Apr 2001 16:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132690AbRDQUtO>; Tue, 17 Apr 2001 16:49:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43537 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132678AbRDQUs7>; Tue, 17 Apr 2001 16:48:59 -0400
Subject: Re: I can eject a mounted CD
To: pochini@denise.shiny.it (Giuliano Pochini)
Date: Tue, 17 Apr 2001 21:50:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, lna@bigfoot.com
In-Reply-To: <3ADB4511.E3F6F6F1@denise.shiny.it> from "Giuliano Pochini" at Apr 16, 2001 09:16:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pcR4-0003E2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > /dev/cdrom        /mnt/cdrom        auto        noauto,user,ro    0 0
> > 
> > And remove the other cdrom listing. This will allow mounting any
> > supported format and eliminate the duel support for one device.
> 
> That's not the point. The kernel should not allow someone to
> eject a mounted media.

rpm -e magicdev


