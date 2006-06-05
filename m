Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932376AbWFEBcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWFEBcZ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWFEBcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:32:25 -0400
Received: from havoc.gtf.org ([69.61.125.42]:33424 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932376AbWFEBcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:32:24 -0400
Date: Sun, 4 Jun 2006 21:32:23 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: merging new drivers (was Re: 2.6.18 -mm merge plans)
Message-ID: <20060605013223.GD17361@havoc.gtf.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 01:50:11PM -0700, Andrew Morton wrote:
> areca-raid-linux-scsi-driver.patch

>   I'm going to start sending the Areca driver to James, too.  The vendor
>   has worked hard and the hardware is becoming more important - let's help
>   them get it in.


In general, I'm a bit disappointed at the time it takes new drivers to
reach the upstream kernel.  I grant that a lot of vendor drivers are
unreadable, unmergable shite...  but on the other side of the coin, I
see a lot of decent drivers get stalled simply because they aren't
perfect.

I would rather see a driver get "95% there" -- because once a driver is
merged into the upstream kernel, it has a lot more visibility, and will
inevitably receive the remaining changes and cleanups anyway.

	Jeff



