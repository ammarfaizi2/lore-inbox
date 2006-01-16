Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWAPIm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWAPIm2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 03:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWAPIm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 03:42:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27980 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932253AbWAPIm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 03:42:27 -0500
Date: Mon, 16 Jan 2006 09:44:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Documentation/block/barrier.txt got lost, add it back
Message-ID: <20060116084428.GP3945@suse.de>
References: <11372222783378-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11372222783378-git-send-email-htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14 2006, Tejun Heo wrote:
> barrier.txt got lost while the new barrier patchset was climbing up
> the ladder to the mainline.  Add it back.

Must have been a missing git-update-index --add, thanks I've queued it
up for Linus.

-- 
Jens Axboe

