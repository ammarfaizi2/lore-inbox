Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317882AbSFSNwE>; Wed, 19 Jun 2002 09:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317888AbSFSNwD>; Wed, 19 Jun 2002 09:52:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48072 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317882AbSFSNwC>;
	Wed, 19 Jun 2002 09:52:02 -0400
Date: Wed, 19 Jun 2002 15:51:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "Andre M. Hedrick" <andre@linux-ide.org>
Subject: [PATCH] ide+block tag support, 2.4.19-pre10
Message-ID: <20020619135154.GD812@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I updated the tcq patches to 2.4.19-pre10. Changes:

- (block) Port to 2.4.19-pre10
- (block) Sync with 2.5 (blk_queue_find_tag stuff)

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.4/2.4.19-pre10/ide-block-tag-2419p10-1.bz2

There are also separate patches for ide and block layer.

-- 
Jens Axboe

