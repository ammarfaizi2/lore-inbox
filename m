Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTITWRx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 18:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbTITWRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 18:17:53 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:4027 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261973AbTITWRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 18:17:53 -0400
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <3F6C9C55.6050608@pobox.com>
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se>
	 <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk>
	 <20030913184934.GB10047@gtf.org> <20030913190131.GD10047@gtf.org>
	 <20030915073445.GC27105@suse.de> <20030916194955.GC5987@gtf.org>
	 <20030916195515.GC906@suse.de>  <3F6C9C55.6050608@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064096170.23121.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Sat, 20 Sep 2003 23:16:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-20 at 19:28, Jeff Garzik wrote:
> sg needs some modifications -- for example it errors out instead of 
> sleeps on queue full -- but sounds good to me.

Is that an error and change in behaviour ?

