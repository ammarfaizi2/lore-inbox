Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbTJGQ2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbTJGQ2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:28:32 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:34274 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262474AbTJGQ2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:28:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: tigran@aivazian.fsnet.co.uk, Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: [PATCH] [2.4.XX] Silicon Image/CMD Medley Software RAID
Date: Tue, 7 Oct 2003 18:31:50 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <30270451.1065543294483.JavaMail.www@wwinf3005>
In-Reply-To: <30270451.1065543294483.JavaMail.www@wwinf3005>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310071831.50104.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/ide/pci/siimage.c
Did you forget to compile it? :-)

On Tuesday 07 of October 2003 18:14, tigran@aivazian.fsnet.co.uk wrote:
> Greetings Mark!
>
> I put linux-kernel back, in case someone else has ideas.
>
> > what controller does it have?  the web page, sadly, doesn't give lspci
> > output ;)
>
> I will check it (the card is at home and I am in the office) and let you
> know. From memory it was something like:
>
> "Silicon Image PCI0680"
>
> (or something like that)
>
> > the correct term is "broken", not "slow".
>
> Well, if it, as you say, works in "ata compatibility mode"
> and there is no specific driver (in Linux) then it is not
> broken but (currently, under Linux) just _very_ slow,
> until someone writes a specific driver for that chipset.
>
> But I am not interested in subtle semantics of "slow" vs "broken".
> All I want is for my data to arrive at the disk (and come back, sometimes)
> a bit faster! :)
>
> Kind regards
> Tigran

