Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbUCHAoH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 19:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbUCHAoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 19:44:06 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:18904 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262357AbUCHAoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 19:44:03 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: John Covici <covici@ccs.covici.com>
Subject: Re: shuttle an50r Motherboard and Linux
Date: Mon, 8 Mar 2004 01:51:28 +0100
User-Agent: KMail/1.5.3
References: <m3wu5w8aex.fsf@ccs.covici.com>
In-Reply-To: <m3wu5w8aex.fsf@ccs.covici.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403080151.28816.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Monday 08 of March 2004 01:11, John Covici wrote:
> Hi.  I have had a couple of problems trying to get this Motherboard
> to work correctly under Linux.
>
> The Ethernet 10/100 is supposed to be an RC82540m, but the e100
> module does not recognize it.  If you do an lspci it doesn't say
> Intel at all, but just Nvidia and Shuttle.  Am I doing something
> wrong, or is there a better driver in 2.6 than 2.4 or what?
>
> Also, I am using the amd74xx driver for the chip set, but it does not
> seem to activate dma or announce udma and a number as the via one
> does -- is this the correct driver?

What kernel version(s) are you using?
What are the boot messages ('dmesg' command output)?
What is the output of 'lspci' command?

Regards,
Bartlomiej

