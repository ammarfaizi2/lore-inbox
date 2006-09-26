Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWIZWnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWIZWnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWIZWnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:43:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56273 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932454AbWIZWnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:43:00 -0400
Subject: Re: pata_serverworks oopses in latest -git
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Diego Calleja <diegocg@gmail.com>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060927002149.06c934e8.diegocg@gmail.com>
References: <20060926140016.54d532ba.diegocg@gmail.com>
	 <1159275010.11049.215.camel@localhost.localdomain>
	 <45194DAD.6060904@garzik.org> <20060926212939.69b52f0d.diegocg@gmail.com>
	 <1159300946.11049.300.camel@localhost.localdomain>
	 <20060926223857.56b0047d.diegocg@gmail.com>
	 <1159305871.11049.316.camel@localhost.localdomain>
	 <20060927002149.06c934e8.diegocg@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 27 Sep 2006 00:06:48 +0100
Message-Id: <1159312008.11049.323.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-27 am 00:21 +0200, ysgrifennodd Diego Calleja:
> That made things work! I can confirm I can read CDs, but I wasn't
> able to read DVDs, though.

That appears to a hardware problem


> [  129.270661] sr 2:0:0:0: SCSI error: return code = 0x08000002
> [  129.270675] sr0: Current: sense key=0x3

MEDIUM ERROR. As reported by the drive.


