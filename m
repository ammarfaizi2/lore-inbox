Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUHTOLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUHTOLz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUHTOLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:11:55 -0400
Received: from the-village.bc.nu ([81.2.110.252]:53895 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266366AbUHTOLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:11:54 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel@wildsau.enemy.org, fsteiner-mail@bio.ifi.lmu.de,
       diablod3@gmail.com,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <4125FFA2.nail8LD61HFT4@burner>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	 <4124BA10.6060602@bio.ifi.lmu.de>
	 <1092925942.28353.5.camel@localhost.localdomain>
	 <200408191800.56581.bzolnier@elka.pw.edu.pl>
	 <4124D042.nail85A1E3BQ6@burner>
	 <1092938348.28370.19.camel@localhost.localdomain>
	 <4125FFA2.nail8LD61HFT4@burner>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093007370.30940.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 Aug 2004 14:09:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-20 at 14:41, Joerg Schilling wrote:
> > While Sun did spend a year refusing to fix security holes I found -  for
> > "compatibility reasons" - long ago back when I was a sysadmin at NTL,
> > the Linux world does not work that way.
> 
> Unless you tell us what kind of "security holes" you found _and_ when this has 
> been, it looks like a meaningless remark.

Solaris of 2.5 era had bugs that allowed any user with rsh access to
issue network configuration ioctls. The sun engineers fixed the bug the
day I reported it then various other people refused to allow it out for
a year.

Linux doesn't work this way. We fix security bugs as a priority.

