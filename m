Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbUCSQsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 11:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbUCSQsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 11:48:31 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:45066 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263131AbUCSQs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 11:48:29 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] barrier patch set
Date: Fri, 19 Mar 2004 17:48:17 +0100
User-Agent: KMail/1.6.1
Cc: Jens Axboe <axboe@suse.de>, Chris Mason <mason@suse.com>
References: <20040319153554.GC2933@suse.de>
In-Reply-To: <20040319153554.GC2933@suse.de>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403191748.17414@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 March 2004 16:35, Jens Axboe wrote:

Hi Jens,

> A first release of a collected barrier patchset for 2.6.5-rc1-mm2. I
> have a few changes planned to support dm/md + sata, I'll do those
> changes over the weekend.
> Reiser has the best barrier support, ext3 works but only if things don't
> go wrong. So only attempt to use the barrier feature on ext3 if on ide
> drives, not SCSI nor SATA.
> reiserfs-barrier-2.6.5-rc1-mm2-1
> 	reiser part.

is this intended? ;)

-rw-------    1 axboe    axboe        3377 Mar 19 07:32 
reiserfs-barrier-2.6.5-rc1-mm2-1.bz2
-rw-------    1 axboe    axboe         248 Mar 19 07:32 
reiserfs-barrier-2.6.5-rc1-mm2-1.bz2.sign
-rw-------    1 axboe    axboe        3473 Mar 19 07:32 
reiserfs-barrier-2.6.5-rc1-mm2-1.gz
-rw-------    1 axboe    axboe         248 Mar 19 07:32 
reiserfs-barrier-2.6.5-rc1-mm2-1.gz.sign
-rw-------    1 axboe    axboe         248 Mar 19 07:32 
reiserfs-barrier-2.6.5-rc1-mm2-1.sign

means permission denied for us.


ciao, Marc
