Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131215AbRABSEJ>; Tue, 2 Jan 2001 13:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131078AbRABSDu>; Tue, 2 Jan 2001 13:03:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3091 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130998AbRABSDm>; Tue, 2 Jan 2001 13:03:42 -0500
Subject: Re: Error with RAID:  Physical Drive 0:1 killed due to SCSI phase
To: tim@radioamp.com (Tim Bithoney)
Date: Tue, 2 Jan 2001 17:35:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <B67771FF.253A%tim@radioamp.com> from "Tim Bithoney" at Jan 02, 2001 11:54:40 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DVLH-0002Zu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This happens 1 time per week it seems, I can fix it manually by doing Alt-R
> and marking all drives as online again. But essentially we lose the RAID
> each week because of these sequence errors and then we need to reboot and
> fix the RAID card, then its fine for a week.

Report it to the maintainer , address in the driver. From memory I believe this
occurs if you use drives with bugs. There is a Mylex list of 'approved' drives
and if you stray from it so be it. I dont think its a Linux thing


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
