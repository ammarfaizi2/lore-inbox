Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbTE1Hg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbTE1Hg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:36:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25003 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264610AbTE1HgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:36:25 -0400
Date: Wed, 28 May 2003 09:49:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Andy Polyakov <appro@fy.chalmers.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-70 ide-cd to guarantee fault-free CD/DVD burning experience?
Message-ID: <20030528074941.GV845@suse.de>
References: <3ED4681A.738DA3C6@fy.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED4681A.738DA3C6@fy.chalmers.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Andy Polyakov wrote:
> As for scsi_ioctl.c in more general sense. It apparently doesn't comply
> with SG HOWTO, in particular it mis-interprets time-out values.
> Background information and patch is available at
> http://fy.chalmers.se/~appro/linux/DVD+RW/scsi_ioctl-2.5.69.patch.

Looks straight forward, applied.

-- 
Jens Axboe

