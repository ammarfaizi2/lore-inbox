Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129678AbRBKQW6>; Sun, 11 Feb 2001 11:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129643AbRBKQWs>; Sun, 11 Feb 2001 11:22:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39948 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129614AbRBKQWi>; Sun, 11 Feb 2001 11:22:38 -0500
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
To: david@blue-labs.org (David Ford)
Date: Sun, 11 Feb 2001 10:53:49 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), daniel@kabuki.eyep.net (Daniel Stone),
        mason@suse.com (Chris Mason), dbr@spoke.nols.com (David Rees),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        reiserfs-list@namesys.com (reiserfs-list@namesys.com)
In-Reply-To: <3A85AFC8.9070107@blue-labs.org> from "David Ford" at Feb 10, 2001 01:16:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Ru8e-0003qq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> run reiserfs on several servers, workstations, and a notebook.  I have 
> current kernels and have watched carefully for corruption.  I haven't 
> seen any evidence of corruption on any of them including my notebook 
> which has a bad battery and bad power connection so it tends to 
> instantly die.
> 
> Alan, is there a particular trigger to this?

The 2.4.1 stuff is a specific low level block I/O pattern. Its fixed in
2.4.2pre2/2.4.1ac-something

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
