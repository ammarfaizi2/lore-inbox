Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUHTOZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUHTOZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUHTOZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:25:27 -0400
Received: from avalon.servus.at ([193.170.194.18]:42881 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S266880AbUHTOZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:25:21 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Message-Id: <200408201424.i7KEORxb004765@wildsau.enemy.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <4125FFA2.nail8LD61HFT4@burner>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 20 Aug 2004 16:24:27 +0200 (MET DST)
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       fsteiner-mail@bio.ifi.lmu.de, diablod3@gmail.com,
       B.Zolnierkiewicz@elka.pw.edu.pl
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > While Sun did spend a year refusing to fix security holes I found -  for
> > "compatibility reasons" - long ago back when I was a sysadmin at NTL,
> > the Linux world does not work that way.
> 
> Unless you tell us what kind of "security holes" you found _and_ when this has 
> been, it looks like a meaningless remark.

Well ... despite the danger, that this email ist just another meaninless
remark, too, I'd say that Sun acts like any other big software company: they
don't listen to single persons reporting bugs, and tend to blame misbehaviour
of software on you. Personal experience: I implemented some smartcard driver,
it didn't work, I identified a bug, reported it. Sun said: "your software is
buggy". It was only after our client (a big company) intervened, that Sun modified
their kernel drivers (allthough I think the error was "below" that).
Even though I exactly told them how to reproduce the bug, they were not able to.
Two co-workes had to go to Sun in San Francisco - and they instantly were able to
reproduce the bug on Sun's machine.

Typical scenario: small sw-company reports bugs -> reply: "you are too unskilled".
                  big company enters the scene -> things are getting fixed.

So, you see, Sun is not per se impeccable.

best regards,
H.Rosmanith

