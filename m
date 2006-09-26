Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWIZTiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWIZTiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWIZTiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:38:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63937 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932112AbWIZTiI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:38:08 -0400
Subject: Re: pata_serverworks oopses in latest -git
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Diego Calleja <diegocg@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060926212939.69b52f0d.diegocg@gmail.com>
References: <20060926140016.54d532ba.diegocg@gmail.com>
	 <1159275010.11049.215.camel@localhost.localdomain>
	 <45194DAD.6060904@garzik.org>  <20060926212939.69b52f0d.diegocg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Tue, 26 Sep 2006 21:02:26 +0100
Message-Id: <1159300946.11049.300.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-26 am 21:29 +0200, ysgrifennodd Diego Calleja:
> El Tue, 26 Sep 2006 11:56:29 -0400,
> Jeff Garzik <jeff@garzik.org> escribió:
> 
> > Diego, does the attached patch help?
> 
> Yes and no :) It fixes that problem but I hit another oops, but this
> time it's triggered because it hits the BUG() at:

Burble.....

Can you send me an lspci -vxxx of your serverworks controller. That
shouldn't be possible so I must have the table wrong.

