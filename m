Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288854AbSAQOev>; Thu, 17 Jan 2002 09:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288855AbSAQOel>; Thu, 17 Jan 2002 09:34:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50706 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288835AbSAQOe3>;
	Thu, 17 Jan 2002 09:34:29 -0500
Date: Thu, 17 Jan 2002 15:34:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "Andre M. Hedrick" <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.3-pre1 ata-253p1-2
Message-ID: <20020117153421.O20994@suse.de>
In-Reply-To: <20020117144648.L20994@suse.de> <5.1.0.14.2.20020117141843.02615430@pop.cus.cam.ac.uk> <20020117152945.N20994@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020117152945.N20994@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17 2002, Jens Axboe wrote:
> On Thu, Jan 17 2002, Anton Altaparmakov wrote:
> > Hi Jens,
> > 
> > I think there is a bug here...
> 
> BTW, should have mentioned that this code doesn't trigger right now
> anyways so it's only a source bug, not a binary one.

Since the bug was cosmetic only, I won't include it here. Find the
updated version:

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.3-pre1/ata-253p1-2.bz2

-- 
Jens Axboe

