Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbUCGLuh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 06:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbUCGLug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 06:50:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46265 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261819AbUCGLuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 06:50:32 -0500
Date: Sun, 7 Mar 2004 12:50:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI CDROM/DVD trouble with 2.6.3 (2.6.2 is fine)
Message-ID: <20040307115031.GK23525@suse.de>
References: <Pine.LNX.4.56.0403051745430.21208@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0403051745430.21208@jju_lnx.backbone.dif.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05 2004, Jesper Juhl wrote:
> 
> Hi,
> 
> I'm currently running 2.6.2 on a system with an Adaptec 29160N SCSI
> controller, an IBM UltraStar Ultra160 SCSI disk, A Plextor SCSI CD writer
> and a Pioneer SCSI DVD-ROM drive.
> With 2.6.2 everything functions perfectly (did so with 2.4.x as well) and
> I have no trouble what-so-ever.  With 2.6.3 it's a completely different
> matter.

Try 2.6.4-rc, this problem was reported and fixed weeks ago.

-- 
Jens Axboe

