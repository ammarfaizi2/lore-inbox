Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288842AbSAQOaV>; Thu, 17 Jan 2002 09:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288871AbSAQOaM>; Thu, 17 Jan 2002 09:30:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31250 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288842AbSAQO3w>;
	Thu, 17 Jan 2002 09:29:52 -0500
Date: Thu, 17 Jan 2002 15:29:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "Andre M. Hedrick" <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] 2.5.3-pre1 ide updates
Message-ID: <20020117152945.N20994@suse.de>
In-Reply-To: <20020117144648.L20994@suse.de> <5.1.0.14.2.20020117141843.02615430@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020117141843.02615430@pop.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17 2002, Anton Altaparmakov wrote:
> Hi Jens,
> 
> I think there is a bug here...

BTW, should have mentioned that this code doesn't trigger right now
anyways so it's only a source bug, not a binary one.

-- 
Jens Axboe

