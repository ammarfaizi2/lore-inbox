Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVAYIFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVAYIFn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 03:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVAYIFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 03:05:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25513 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261864AbVAYIFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 03:05:41 -0500
Date: Tue, 25 Jan 2005 09:05:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Elias da Silva <silva@aurigatec.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
Message-ID: <20050125080539.GA2751@suse.de>
References: <200501220327.38236.silva@aurigatec.de> <200501242059.06307.silva@aurigatec.de> <20050124203948.GR2707@suse.de> <200501242310.00184.silva@aurigatec.de> <1106611309.6148.116.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106611309.6148.116.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25 2005, Alan Cox wrote:
> Someone did actually have a demo of a small fs that allowed you to
> fiddle with the status but possibly the code could get smarter for
> "exclusive user of media". I'm not sure if that is worth it.

I think it is worth it, on the grounds that this is a never ending farce
on what commands should be what type and for what device. At least the
fs would allow people to easily customize for their setup.

-- 
Jens Axboe

