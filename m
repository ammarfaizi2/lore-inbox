Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270984AbTGVSad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270986AbTGVSad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:30:33 -0400
Received: from codepoet.org ([166.70.99.138]:54912 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S270984AbTGVSac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:30:32 -0400
Date: Tue, 22 Jul 2003 12:45:33 -0600
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Promise SATA driver GPL'd
Message-ID: <20030722184532.GA2321@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some folk I've done some consulting work for bought a zillion
Promise SATA cards.  They were able to convince Promise to
release their SATA driver, which was formerly available only as 
a binary only kernel module, under the terms of the GPL.

So <drum-roll, trumpets> here it is: the Promise SATA driver for
the PDC20318, PDC20375, PDC20378, and PDC20618.  This driver is
released as-is.  It is useful for the

	Promise SATA150 TX4
	Promise SATA150 TX2plus
	Promise SATA 378
	Promise Ultra 618

cards.  As a temporary download location, the GPL'd driver can be
obtained from http://www.busybox.net/pdc-ultra-1.00.0.10.tgz

Have fun!  And many thanks to Promise for contributing the driver
for their cards!

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
