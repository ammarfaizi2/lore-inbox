Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbTIRTex (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 15:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTIRTex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 15:34:53 -0400
Received: from havoc.gtf.org ([63.247.75.124]:11448 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262080AbTIRTew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 15:34:52 -0400
Date: Thu, 18 Sep 2003 15:34:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Poirier <dpoirier@telecomoptions.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VT6410 support
Message-ID: <20030918193452.GB9605@gtf.org>
References: <20030918132550.GA18933@telecomoptions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030918132550.GA18933@telecomoptions.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 08:25:50AM -0500, Dave Poirier wrote:
> I'm attempting to get the VT6410 controller to work on an Intel P4P800
> motherboard and I seem to be out of luck with both the 2.4.x and 2.6.x
> series.
> 
> Does anyone has details concerning VT6410 (Via Raid Controller)?

Both libata and drivers/ide support the SATA portion.

Ignore the "RAID", it's really software-ish RAID.

	Jeff


