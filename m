Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283266AbRLROAW>; Tue, 18 Dec 2001 09:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282981AbRLROAM>; Tue, 18 Dec 2001 09:00:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37389 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283916AbRLROAA>; Tue, 18 Dec 2001 09:00:00 -0500
Subject: Re: Scheduler ( was: Just a second ) ...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 18 Dec 2001 14:09:16 +0000 (GMT)
Cc: riel@conectiva.com.br (Rik van Riel),
        davidel@xmailserver.org (Davide Libenzi),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0112171825460.2108-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 17, 2001 06:35:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16GKvk-0007Sc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> to CD-RW disks without having to know about things like "ide-scsi" etc,
> and do it sanely over different bus architectures etc.
> 
> The scheduler simply isn't that important.

The scheduler is eating 40-60% of the machine on real world 8 cpu workloads.
That isn't going to go away by sticking heads in sand.
