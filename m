Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbUKOPZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUKOPZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 10:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbUKOPZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 10:25:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:24034 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261429AbUKOPZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 10:25:27 -0500
Subject: Re: 2.4.27 suddenly hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: zergio <zergio@isma.kharkov.ua>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <419886CE.2030304@isma.kharkov.ua>
References: <419886CE.2030304@isma.kharkov.ua>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1100528528.27208.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 15 Nov 2004 14:22:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-15 at 10:37, zergio wrote:
> Hello, all!
> I‘m not sure that the below problem is kernel related, however, I think, 
> this mailing list is the best place to start. I've got 2x1.8 Xeon on 
> Intel SE7500CW2 motherboard with Intel SCSI RAID (GDT driver). The 
> system powered by Red Hat Linux 7.3 with custom kernel version 2.4.27.

Go into the bios and disable USB keyboard support and USB storage/boot
off USB devices (however they phrase this in your BIOS). That *may*
help. It does for some similar reports.

