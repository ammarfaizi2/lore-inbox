Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129894AbQLHOTl>; Fri, 8 Dec 2000 09:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131848AbQLHOTb>; Fri, 8 Dec 2000 09:19:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16400 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132147AbQLHOTT>; Fri, 8 Dec 2000 09:19:19 -0500
Subject: Re: who is writing to disk
To: zhiruo@cc.gatech.edu (Zhiruo Cao)
Date: Fri, 8 Dec 2000 13:50:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, zhiruo@cc.gatech.edu
In-Reply-To: <Pine.GSU.4.21.0012072119450.9251-100000@lennon.cc.gatech.edu> from "Zhiruo Cao" at Dec 07, 2000 09:25:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144Nv5-0003ud-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My question then is, is there a (monitoring) tool that can tell me who is
> writing to disk?  Or how I configure the kernel to know that?

Monitoring tool - none that I know of. FInd can do a search and find all very
new files.

Most likely it's a combination of cruddy CD-ROM drives and magicdev. See
if /var/log/messages has an ever growing rant from the cdrom drive


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
