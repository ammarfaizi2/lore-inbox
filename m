Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWBFU0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWBFU0n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWBFU0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:26:42 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:58567 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964777AbWBFU0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:26:41 -0500
Subject: Re: DMA in PCI chipset -- module vs. compiled-in
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, William Park <opengeometry@yahoo.ca>
In-Reply-To: <200602062032.09159.ioe-lkml@rameria.de>
References: <20060206034312.GA2962@node1.opengeometry.net>
	 <1139200372.2791.208.camel@mindpipe>
	 <200602062032.09159.ioe-lkml@rameria.de>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 15:26:39 -0500
Message-Id: <1139257599.2791.299.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 20:31 +0100, Ingo Oeser wrote:
> Hi Lee,
> 
> On Monday 06 February 2006 05:32, Lee Revell wrote:
> > This is actually a problem in several areas of the kernel (it's the same
> > for "Generic RTC" vs. the normal RTC) - I don't think the name "Generic"
> > properly reflects that it will prevent more specific device support from
> > working.
> 
> What about "Fallback $DEVICE" instead?

Yes, that would be much better for the RTC case.

Lee

