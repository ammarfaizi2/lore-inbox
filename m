Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTICMmv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTICMmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:42:51 -0400
Received: from imap.gmx.net ([213.165.64.20]:38083 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262055AbTICMmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:42:49 -0400
From: "Sebastian Piecha" <spi@gmxpro.de>
To: "=?ISO-8859-1?Q?Tomasz__B=B1tor?=" <tomba@bartek.tu.kielce.pl>,
       linux-kernel@vger.kernel.org
Date: Wed, 03 Sep 2003 14:42:52 +0200
MIME-Version: 1.0
Subject: Re: What is the SiI 0680 chipset status?
Message-ID: <3F55FDEC.28048.34FF5921@localhost>
In-reply-to: <20030902165537.GA1830@bartek.tu.kielce.pl>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi to all.
> I recently got MiNt PCI IDE ATA/133 RAID controller based on SiI 0680
> chipset. I browsed through the archives and I know that the driver is
> known to be broken and simply doesn't work.
> 
> That was some time ago, meanwhile there were some fixes/hdparm
> almost-solutions, but none of them seems to work. I remember that
> Andre Hendrick said he's talking with SiI guys to find a final
> solution, but no more info after that...
> 
> Therefore my question is: what is the current status of this driver?
> Are there any patches available? Or I will have to just buy another
> controller? (No problems with HPT or Promise?)
> 
I recently posted a problem with a Promise 
UltraTrak 133 TX2 controller (subject: PROBLEM: Powerquest Drive 
Image let the kernel panic). With kernel 2.4.20 every time moving 
several GB of data I get an OOPS. I already thought trying a 
controller with a SI680-chipset... Maybe that's not a good idea.

Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

