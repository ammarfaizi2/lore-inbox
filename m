Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268440AbUJDGV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268440AbUJDGV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 02:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268448AbUJDGV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 02:21:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64214 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268440AbUJDGV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 02:21:56 -0400
Date: Mon, 4 Oct 2004 08:19:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: michf@post.tau.ac.il
Subject: Re: 2.6.9-rc3 lost cdrom
Message-ID: <20041004061902.GC2287@suse.de>
References: <20041003021055.GA3227@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041003021055.GA3227@luna.mooo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03 2004, Micha Feigin wrote:
> I seem to have lost cdrom support through scsi emulation, any ideas?
> (its a burner, and drive detection with xcdroast in ide mode is
> terrible, takes minutes).

So did it work in 2.6.9-rc2?

-- 
Jens Axboe

