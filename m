Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbTIMTBc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 15:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTIMTBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 15:01:32 -0400
Received: from havoc.gtf.org ([63.247.75.124]:52627 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261971AbTIMTBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 15:01:31 -0400
Date: Sat, 13 Sep 2003 15:01:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: axboe@suse.de, torvalds@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Message-ID: <20030913190131.GD10047@gtf.org>
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se> <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk> <20030913184934.GB10047@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913184934.GB10047@gtf.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, and I'm pondering the best way to deliver out-of-bang ATA taskfiles
and SCSI cdbs to a device.  (for the uninitiated, this is lower level
than block devices / cdrom devices / etc.)

 ... AF_BLOCK is not out of the question ;-)

	Jeff


