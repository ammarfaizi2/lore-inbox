Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWAQQXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWAQQXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWAQQXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:23:38 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:27356 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932110AbWAQQXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:23:38 -0500
To: Jeff Garzik <jgarzik@pobox.com>
cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: sata_mv important note 
In-reply-to: <43CD07D5.30302@pobox.com> 
References: <43CD07D5.30302@pobox.com>
Comments: In-reply-to Jeff Garzik <jgarzik@pobox.com>
   message dated "Tue, 17 Jan 2006 10:05:57 -0500."
Date: Tue, 17 Jan 2006 09:24:26 -0700
From: Sebastian Kuzminsky <seb@highlab.com>
Message-Id: <E1EytdC-0006DE-IS@highlab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
> For sata_mv users, you should be aware of three things:
> 
> 1) The Marvell driver is experimental, and not yet considered ready for 
> production use.  As Kconfig notes: HIGHLY EXPERIMENTAL.

Right, understood.

Can anyone recommend a 4xSATA (or more) controller on a PCI-X card that
_is_ ready for production use?  eSATA ports are prefered but not required.
Support for hotplug, power management (spindown) and SMART is prefered
but not required.

Anyone?


> Rest assured that all problem reports are read, even if you don't 
> receive a reply.  After enough feedback is received, the exact problem 
> becomes more clear.

Thanks Jeff!


-- 
Sebastian Kuzminsky
