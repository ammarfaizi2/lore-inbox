Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTDIK0w (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 06:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbTDIK0w (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 06:26:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17280 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262993AbTDIK0v (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 06:26:51 -0400
Date: Wed, 9 Apr 2003 12:38:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] z2ram fix (was: Re: Linux 2.5.67)
Message-ID: <20030409103827.GA835@suse.de>
References: <Pine.LNX.4.44.0304071051190.1385-100000@penguin.transmeta.com> <Pine.GSO.4.21.0304091044230.21742-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0304091044230.21742-100000@vervain.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09 2003, Geert Uytterhoeven wrote:
> On Mon, 7 Apr 2003, Linus Torvalds wrote:
> > Jens Axboe:
> >   o kill blk_queue_empty()
> 
> This change contained a typo, here's a fix:

Ugh, thanks!

-- 
Jens Axboe

