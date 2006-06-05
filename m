Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932353AbWFEAc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWFEAc4 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 20:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWFEAcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 20:32:55 -0400
Received: from havoc.gtf.org ([69.61.125.42]:50830 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932349AbWFEAcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 20:32:54 -0400
Date: Sun, 4 Jun 2006 20:32:50 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: new SCSI drivers (was Re: 2.6.18 -mm merge plans)
Message-ID: <20060605003250.GA17361@havoc.gtf.org>
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

The driver gets my ACK.

Also, I have the Promise 'stex' (previously 'shasta') SCSI RAID driver
in jgarzik/misc-2.6.git#stex that wants merging.

It's been sent to linux-scsi and linux-kernel several times, but
never seemed to make it into a SCSI tree.  I kept it alive in #stex,
and AFAICS it's been ready to merge for a while now.

I'll send it to linux-scsi one more time, sometime this week.

	Jeff



