Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVEPPCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVEPPCZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEPPA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:00:59 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:52447 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261676AbVEPO7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:59:17 -0400
Subject: Re: Linux does not care for data integrity (was: Disk write cache)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1116241957.6274.36.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
	 <200505151121.36243.gene.heskett@verizon.net>
	 <20050515152956.GA25143@havoc.gtf.org>
	 <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
	 <42877C1B.2030008@pobox.com>  <20050516110203.GA13387@merlin.emma.line.org>
	 <1116241957.6274.36.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116255439.21388.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 May 2005 15:57:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-05-16 at 12:12, Arjan van de Ven wrote:
> Sure you can waive rethorics around, but the fact is that linux is
> improving; there now is write barrier support for ext3 (and I assume
> reiserfs) for at least IDE and iirc selected scsi too. 

scsi supports tagging so ext3 at least is just fine.

